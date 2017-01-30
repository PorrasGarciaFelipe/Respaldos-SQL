
select * from Proyectos
where Proyecto like '%ENC%'

select * from AoDestajosEst
where IdProyecto=16

select * from AoDestajosEstDet

select * from AoDestajosEstCC


//ubicaciones
select * from Centros 
where idProyecto=16

select * from AoPresupuestoControl
where IdProyecto=16

select * from AoPartidas
where IdProyecto=16

select * from AoCatConceptos
where idProyecto=16

/////////////////////////////////////////////////////////////////////////////////////

select t1.partida,t1.descripcion, t3.descripcionlarga
from AoPartidas t1 
inner join AoPresupuestoControl t2 on t1.idPartida=t2.idPartida 
inner join AoCatConceptos t3 on t2.idConcepto=t3.idConcepto
where t1.IdProyecto=16
order by t1.Partida asc

/////////////////////////////////////////////////////

select t1.partida,t1.descripcion, t3.descripcionlarga, t4.centro, t4.descripcion
from AoPartidas t1 
inner join AoPresupuestoControl t2 on t1.idPartida=t2.idPartida 
inner join AoCatConceptos t3 on t2.idConcepto=t3.idConcepto 
inner join AoDestajosEstDet t5 on t2.IdPresupuestoControl=t5.IdPresupuestoControl
inner join AoDestajosEstCC t6 on t5.IdDestajoDet=t6.IdDestajoDet
inner join Centros t4 on t4.idCentro=t6.idCentro
where t1.IdProyecto=16
order by t1.Partida asc



//////////////////////////////////////////////////////////////////

//BRENA

select t1.partida,t1.descripcion, t3.descripcionlarga, t4.centro, t4.descripcion
from AoPartidas t1 
inner join AoPresupuestoControl t2 on t1.idPartida=t2.idPartida 
inner join AoCatConceptos t3 on t2.idConcepto=t3.idConcepto 
inner join AoDestajosEstDet t5 on t2.IdPresupuestoControl=t5.IdPresupuestoControl
inner join AoDestajosEstCC t6 on t5.IdDestajoDet=t6.IdDestajoDet
inner join Centros t4 on t4.idCentro=t6.idCentro
where t1.IdProyecto=8
order by t1.Partida asc

////////////////////////////////////////////////////////////////////////

/*ESTIMACIONES POR PARTIDA / CONCEPTO */

select t1.partida,t1.descripcion, t3.descripcionlarga, t5.Cantidad, t5.Costo, t5.Importe
from AoPartidas t1 
inner join AoPresupuestoControl t2 on t1.idPartida=t2.idPartida 
inner join AoCatConceptos t3 on t2.idConcepto=t3.idConcepto 
inner join AoDestajosEstDet t5 on t2.IdPresupuestoControl=t5.IdPresupuestoControl
where t1.IdProyecto=16
order by t1.Partida asc


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


select cast(t1.partida as varchar(20)),cast(t1.descripcion as varchar(50)), cast(t3.descripcionlarga as varchar(1000)),sum(t5.Cantidad), t5.Costo , sum(t5.Importe)as importe
from AoPartidas t1 
inner join AoPresupuestoControl t2 on t1.idPartida=t2.idPartida 
inner join AoCatConceptos t3 on t2.idConcepto=t3.idConcepto 
inner join AoDestajosEstDet t5 on t2.IdPresupuestoControl=t5.IdPresupuestoControl
where t1.IdProyecto=16
group by 
cast (t1.partida as varchar(20)), 
cast(t1.descripcion as varchar(50)),
cast(t3.descripcionlarga as varchar(1000)),
t5.Costo
order by cast(t1.partida as varchar(20)) asc

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


select cast(t1.partida as varchar(20)),cast(t1.descripcion as varchar(50)), cast(t3.descripcionlarga as varchar(1000)),sum(t6.Importe),sum(t5.Cantidad), t5.Costo , sum(t5.Importe)as importe
from AoPartidas t1 
inner join AoPresupuestoControl t2 on t1.idPartida=t2.idPartida 
inner join AoCatConceptos t3 on t2.idConcepto=t3.idConcepto 
inner join AoDestajosEstDet t5 on t2.IdPresupuestoControl=t5.IdPresupuestoControl
inner join AoPresupuestoControl t7 on t1.idPartida=t7.idPartida 
inner join AoCatConceptos t4 on t2.idConcepto=t4.idConcepto 
inner join AcAlmacenSalidas t6 on t7.IdPresupuestoControl=t6.IdPresupuestoControl
where t1.IdProyecto=16
group by 
cast (t1.partida as varchar(20)), 
cast(t1.descripcion as varchar(50)),
cast(t3.descripcionlarga as varchar(1000)),
t5.Costo
order by cast(t1.partida as varchar(20)) asc


////////////////////////////////////////////////////////////////

/* SALIDAS DE ALMACEN POR PARTIDA */

SELECT * FROM AcAlmacenSalidas 
WHERE idProyecto=16


select t1.partida,t1.descripcion, t3.descripcionlarga, t5.Importe
from AoPartidas t1 
inner join AoPresupuestoControl t2 on t1.idPartida=t2.idPartida 
inner join AoCatConceptos t3 on t2.idConcepto=t3.idConcepto 
inner join AcAlmacenSalidas t5 on t2.IdPresupuestoControl=t5.IdPresupuestoControl
where t1.IdProyecto=16
order by t1.Partida asc



/////////////////////////////////////////////////////////////////////////////

/*SUBCONTRATOS POR PARTIDA*/


select t1.partida,t1.descripcion, t3.descripcionlarga, t5.Cantidad,t5.Costo,t5.CantidadEstimada, t5.Costo*t5.CantidadEstimada
from AoPartidas t1 
inner join AoPresupuestoControl t2 on t1.idPartida=t2.idPartida 
inner join AoCatConceptos t3 on t2.idConcepto=t3.idConcepto 
inner join AoSubcontratosDet t5 on t2.IdPresupuestoControl=t5.IdPresupuestoControl
Inner join AoSubContratos t6 on t5.idSubcontrato=t6.IdSubContrato
where t1.IdProyecto=16
order by t1.Partida asc


SELECT * FROM AoSubContratos
WHERE IdProyecto=16

SELECT * FROM AoSubcontratosDet

select* from AoSubContratosEst
where IdProyecto=16


select * from AoSubContratosEstDet



SELECT * FROM AoDestajosEst

SELECT * FROM AoDestajosEstDet


SELECT * FROM AcPedidos
WHERE idProyecto=18 AND Pedido=218

select * from AcPedidosDet
where idPedido=3981

delete from AcPedidosDet
where idPedidoDet=8513


SELECT * FROM AcAditivasExplosion
WHERE idProyecto=18 AND FOLIO=31

select * from AcAditivasExplosionDet
where idAditivaExplosion=496


update AcAditivasExplosionDet
set Cantidad=0
where idAditivaExplosionDet=84040

select * from AcExplosionInsumos
where idProyecto=18 and idExplosionInsumos=46821



delete from AcAditivasExplosionDet
where idAditivaExplosionDet=84040


delete from AcAditivasExplosion
where idAditivaExplosion=496 and Folio=31

update AcExplosionInsumos
set CantidadAdicional=0
where idExplosionInsumos=46821 and idProyecto=18


select * from Proyectos where Proyecto like '%6a%'

select * from AcPedidos
where idProyecto = 27 and Pedido=14

update AcPedidos
set Cancelado = 0
where idProyecto = 27 and Pedido=14

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//catalogo de insumos por proyecto

select t2.insumo,t4.Unidad, t2.idtipoinsumo as tipo, t2.descripcion, cast(t2.descripcionlarga as varchar(500))as descripcionLarga,t3.proyecto
from AcExplosionInsumos t1
inner join AcCatInsumos t2 on t1.idInsumo=t2.idInsumo
inner join proyectos t3 on t1.idproyecto=t3.idproyecto
inner join AcCatUnidades t4 on t4.IdUnidad=t2.idUnidad
where t1.idProyecto >23 AND t2.idTipoInsumo=1
order by cast(t2.descripcionlarga as nvarchar(500)) asc
----------------------------------------------------------------------------------


select cast(t4.Insumo as varchar(20)) as insumo, cast(t1.DescripcionLarga as varchar(500)) as descripcionLarga ,t4.Costo as CostoCatalogo, SUM(t1.Cantidad) as CantidadComprada, avg(t1.CostoNeto) as CostoNetoPromedio 
from AcPedidosDet t1
inner join AcRequisicionDet t2 on t1.idRequisicionDet=t2.idRequisicionDet
inner join AcExplosionInsumos t3 on t2.idExplosionInsumos=t3.idExplosionInsumos
inner join AcCatInsumos t4 on t3.idInsumo=t4.idInsumo
where idProyecto=16
group by cast(t4.Insumo as varchar(20)), cast(t1.DescripcionLarga as varchar(500)),t4.Costo
order by cast(t4.Insumo as varchar(20))

select * from AcAlmacenEntradas
where idProyecto=16 and idPedido is null

select Folio, idProveedor,FechaMovimiento, Importe  from AcAlmacenEntradas
where idProyecto= 16 and idpedido is null

select * from AcFacturasProveedores
where idProyecto=16 and idPedido is null and Cancelada=1

select Factura,FechaFactura,DescripcionFactura,AbonoCuentaProveedor
from AcFacturasProveedores
where idProyecto=16 and idPedido is null	