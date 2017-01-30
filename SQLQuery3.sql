
select * from Proyectos
where Proyecto like '%edif nazareno%'
order by IdProyecto

select * from CvViviendas
where IdProyecto=15


//pb
select IdVivienda, Vivienda, PrecioReal, IdPrototipo
from CvViviendas
where IdProyecto=15 and IdPrototipo=5 and PrecioReal=0

update CvViviendas
set PrecioReal = 419000
where IdProyecto=20 and IdPrototipo=5 and PrecioReal=0


//pa
select IdVivienda, Vivienda, PrecioReal, IdPrototipo
from CvViviendas
where IdProyecto=20 and IdPrototipo=6 and PrecioReal=0

update CvViviendas
set PrecioReal = 394000
where IdProyecto=20 and IdPrototipo=6 and PrecioReal=0


select * from AcFacturasProveedores
where idFacturaProveedor>5469

select * from ACResponsables

select * from SegUsuarios


Select t1.Proyecto, t2.RazonSocial,t4.FechaFactura, t4.Factura,t3.Pedido, t5.Nombre
from Proyectos t1
inner join AcPedidos t3 on t1.IdProyecto=t3.idProyecto
inner join AcFacturasProveedores t4 on t3.idPedido=t4.idPedido
inner join AcProveedores t2 on t4.IdProveedor=t2.idProveedor
inner join SegUsuarios t5 on t5.IdUsuario=t4.IdUsuario
where t4.idFacturaProveedor>5450
order by t4.idFacturaProveedor



SELECT * FROM AcBancosEgresos
WHERE IDUSUARIO=64 

SELECT t1.Proyecto, t2.Banco, t3.Folio, t3.Fecha, t3.Monto, t3.Observaciones, t3.Beneficiario, t3.Cheque
FROM Proyectos t1 
inner join AcBancosEgresos t3 on t1.IdProyecto=t3.IdProyecto
inner join AcCuentasBancarias t2 on t3.idCuentaBancaria=t2.idCuentaBancaria
inner join SegUsuarios t4 on t3.idUsuario=t4.IdUsuario
where t4.IdUsuario=64 


select * from AcAlmacenEntradas
where idProyecto=18

select *from AcAlmacenEntradasDet
where idAlmacenEntrada=3074


select * from AcPedidos
where FechaPedido > '2016-08-01 00:00:00.000'



