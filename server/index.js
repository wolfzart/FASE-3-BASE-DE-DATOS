
const express = require("express");
const app = express();
const cors = require("cors");
const pool = require("./db");

//middleware
app.use(cors());
app.use(express.json());

//ROUTES


//**************************************************************
//CONSULTA 4 MOSTRAR PROMEDIO DE UN CURSO EN ESPECIFICO
app.get("/promedio/:grado_curso/:letra_curso",async(req,res)=>{
    try {
        const {grado_curso,letra_curso}=req.params;
        const tablePromedio = await pool.query("select avg(distinct promedio_general) from libro_de_vida where grado_curso=$1 and letra_curso=$2::text",[grado_curso,letra_curso]);
       
        res.json(tablePromedio.rows[0].avg);
    } catch (err) {
        console.error(err.message);
        
    }
});

//CONSULTA 1 ALUMNO CON mejor promedio de la generación de un curso(A,B,C).
app.get("/promedio2/:grado_curso",async(req,res)=>{
    try {
        const {grado_curso}=req.params;
        const tablePromedio = await pool.query("select promedio_general,rut_alumno from libro_de_vida where grado_curso=$1 and letra_curso like 'M%' and promedio_general in (select max(promedio_general) from libro_de_vida)",[grado_curso]);
       
        res.json(tablePromedio.rows);
    } catch (err) {
        console.error(err.message);
        
    }
});
//CONSULTA 2 alumno tiene menos de un 70% de asistencia, el alumno es expulsado
app.get("/asistencia",async(req,res)=>{
    try {
        const asistencia = await pool.query("select distinct nombre from libro_de_vida,alumno where asistencias<140 and libro_de_vida.rut_alumno=alumno.rut");
       
        res.json(asistencia.rows);
    } catch (err) {
        console.error(err.message);
        
    }
});

app.delete("/expulsarAsistencia",async(req,res)=>{
    try {
        const asistencia = await pool.query("delete distinct nombre from libro_de_vida,alumno where asistencias<140 and libro_de_vida.rut_alumno=alumno.rut");
       
        res.json(asistencia.rows);
    } catch (err) {
        console.error(err.message);
        
    }
});

//CONSULTA 3
app.get("/anotaciones",async(req,res)=>{
    try {
        const asistencia = await pool.query("select nombre from libro_de_vida,alumno where anotaciones=3 and libro_de_vida.rut_alumno=alumno.rut");
       
        res.json(asistencia.rows);
    } catch (err) {
        console.error(err.message);
        
    }
});

app.delete("/expulsarAnotaciones",async(req,res)=>{
    try {
        const asistencia = await pool.query("delete nombre from libro_de_vida,alumno where anotaciones=3 and libro_de_vida.rut_alumno=alumno.rut");
       
        res.json(asistencia.rows);
    } catch (err) {
        console.error(err.message);
        
    }
});
// CONSULTA 5
app.get("/deuda",async(req,res)=>{
    try {
        const deuda = await pool.query("select rut_alumno,sum(tesoreria.deuda+tesoreria.interes) as deuda_Total from tesoreria where deuda!=0 group by rut_alumno");
       
        res.send(deuda.rows);
    } catch (err) {
        console.error(err.message);
        
    }
});
//CONSULTA 6
app.get("/horario/:rut",async(req,res)=>{
    try {
        const {rut}=req.params;
        const horario = await pool.query("select distinct A.horario,A.nombre_asignatura,A.dia from asignatura as A, libro_de_vida as L, curso as C where A.grado_curso = L.grado_curso and  A.letra_curso= L.letra_curso and rut_alumno=$1",[rut]);
       
        res.json(horario.rows);
    } catch (err) {
        console.error(err.message);
        
    }
});

//-------------------------------------
app.get("/promedio",async(req,res)=>{
    try {
        const {grado_curso,letra_curso}=req.params;
        const tablePromedio = await pool.query("select avg(distinct promedio_general) from libro_de_vida where grado_curso=1 and letra_curso='M_B'");
       
        res.send(tablePromedio.rows[0].avg);
    } catch (err) {
        console.error(err.message);
        
    }
});
//**************************************************************




app.listen(3000,() => {
    console.log("server has started on port 3000");
});