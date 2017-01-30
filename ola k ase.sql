
select * from AcCatUnidades

select * from AcCatInsumos

select * from AcTiposInsumos


select t2.insumo,t4.Unidad, t2.idtipoinsumo as tipo, t2.descripcion, cast(t2.descripcionlarga as varchar(500))as descripcionLarga,t3.proyecto
from AcExplosionInsumos t1
inner join AcCatInsumos t2 on t1.idInsumo=t2.idInsumo
inner join proyectos t3 on t1.idproyecto=t3.idproyecto
inner join AcCatUnidades t4 on t4.IdUnidad=t2.idUnidad
where t1.idProyecto >23 AND t2.idTipoInsumo=1
order by cast(t2.descripcionlarga as nvarchar(500)) asc

select * from Proyectos
where IdProyecto=16


select * from AcPedidos
where idProyecto=16 

select * from AcPedidosDet

select * from AcRequisicionDet

select * from AcExplosionInsumos

select * from AcCatInsumos


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

select * from Proyectos where Proyecto like '%enc%'

select * from AcAlmacenEntradas
where idProyecto=18 and Folio=584

update AcAlmacenEntradas
set Importe=10542.59
where idProyecto=18 and Folio=584

select * from AcAlmacenEntradasDet
where idAlmacenEntrada=5451

update AcAlmacenEntradasDet
set Costo =7.866
where idAlmacenEntradaDet=11078


	SELECT Insumo,Descripcion,DescripcionLarga FROM AcCatInsumos
	WHERE Insumo LIKE '%MAPV0052%'


select * from Proyectos
where Proyecto like '%5a%'

select * from AcRequisiciones

select t1.idExplosionInsumos, t2.Insumo, t2.DescripcionLarga, CantidadProgramada from 
AcExplosionInsumos t1 inner join AcCatInsumos t2 on t1.idInsumo=t2.idInsumo
where idProyecto=15 and t2.Insumo like '%mamapu174%'


update AcExplosionInsumos
set CantidadProgramada=9.120
where idProyecto=15 and idExplosionInsumos=82621

select * from CvVendedores

select * from CvClientes

select * from CvContratos

select * from CvPlanesPagos

select * from CvPlanesPagosDet


select * from CvTiposPlan