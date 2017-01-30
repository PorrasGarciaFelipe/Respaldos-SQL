
/*Cantidad*/
DECLARE @cols AS NVARCHAR(MAX)
Declare @query  AS nVARCHAR(max)

SELECT @cols = STUFF((SELECT  ',' + QUOTENAME(centro) 
                    FROM Centros
                    where centro like '%27A0%'
            FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)'),1,1,'')
            
select @query='
WITH DESTAJOS (CONCEPTO, UBICACION, DESCRIPCIÓN, UNIDAD, CANTIDAD) AS(
select DISTINCT i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad,sum(t1.Cantidad) 
from accatinsumos i1 
inner join AoCatConceptos i2 on i1.DescripcionLarga like i2.DescripcionLarga
inner join AcCatUnidades u1 on i1.IdUnidad=u1.idUnidad
inner join Proyectos i3 on i2.IdProyecto=i3.idProyecto
inner join AoPresupuestoControl t5 on i2.idConcepto=t5.idConcepto
inner join AoDestajosEstDet t2 on t5.IdPresupuestoControl=t2.IdPresupuestoControl
inner join AoDestajosEstCC t1 on t2.IdDestajoDet=t1.IdDestajoDet
inner join aodestajosEst p2 on p2.iddestajoest=t2.iddestajoest
inner join Centros t9 on t1.idCentro=t9.idCentro
where t9.idProyecto in (select idProyecto from Proyectos where idproyecto=20) and t9.idcentro between 607 and 617 /*and p2.fecha like 2017-01-05*/
group by i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad, t1.Cantidad
)SELECT * FROM DESTAJOS
PIVOT (SUM(CANTIDAD) for
ubicacion in ('+ @cols +')) PVT
ORDER BY CONCEPTO'
EXEC SP_EXECUTESQL @query


select * from AoDestajosEst


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*Costo promedio*/
DECLARE @cols AS NVARCHAR(MAX)
Declare @query  AS nVARCHAR(max)

SELECT @cols = STUFF((SELECT  ',' + QUOTENAME(centro) 
                    FROM Centros
                    where centro like '%37A0%'
            FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)'),1,1,'')
            
select @query='
WITH DESTAJOS (CONCEPTO, UBICACION, DESCRIPCIÓN, UNIDAD, COSTO) AS(
select DISTINCT i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad,AVG(t2.Costo) 
from accatinsumos i1 
inner join AoCatConceptos i2 on i1.DescripcionLarga like i2.DescripcionLarga
inner join AcCatUnidades u1 on i1.IdUnidad=u1.idUnidad
inner join Proyectos i3 on i2.IdProyecto=i3.idProyecto
inner join AoPresupuestoControl t5 on i2.idConcepto=t5.idConcepto
inner join AoDestajosEstDet t2 on t5.IdPresupuestoControl=t2.IdPresupuestoControl
inner join AoDestajosEstCC t1 on t2.IdDestajoDet=t1.IdDestajoDet
inner join Centros t9 on t1.idCentro=t9.idCentro
where t9.idProyecto in (select idProyecto from Proyectos where idproyecto=20) and t9.idcentro between 661 and 668
group by i1.INSUMO, t9.Centro, i1.Descripcion, u1.Unidad, t1.Cantidad
)SELECT * FROM DESTAJOS
PIVOT (AVG(COSTO) for
ubicacion in ('+ @cols +')) PVT
ORDER BY CONCEPTO'
EXEC SP_EXECUTESQL @query




select * from Proyectos
where Proyecto like '%5a-3%'
select * from Centros 
where idProyecto = 20


select * from Centros
where Centro like '%27A0%'
