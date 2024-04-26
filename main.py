import psycopg2
#conexion a base de datos
try :
    connection = psycopg2.connect(
        host = 'localhost',
        user = 'postgres',
        password = 'postgres',
        database = 'Universidad',
        port = '5432'
    )
    print ("conexion exitosa")
except Exception as ex:
    print(ex)
connection.autocommit= True

##insertar estudiante
def insertarEstudiante(nombre, paterno, materno , nacimiento ,carrera):
    cursor = connection.cursor()
    cursor.execute(
        """
            INSERT INTO estudiante(snombre , sappaterno, sapmaterno, dtnacimiento, scarrera)
            VALUES(%s, %s, %s, %s, %s); 
            """,
        (nombre, paterno, materno, nacimiento, carrera)
    )
    cursor.close()
#insertarEstudiante('lucas', 'valencia','calcina', '2004/11/6', 'comercial' )


def verLista(id_materia):
    cursor= connection.cursor()
    cursor.execute(
        """select g.estudiante_id , e.snombre , e.sappaterno , m.snombre
        from registro g 
        join materia m on g.materia_id = m.cod_id 
        join estudiante e on g.estudiante_id = e.ci_id 
        where m.cod_id =%s; 
        """,
        (id_materia)
    )
    for fila in cursor:
        print(fila)

    cursor.close()
    print("consulta terminada")
#verLista('1')



def añadirmateria(id_estudiante, id_materia):
    cursor= connection.cursor()
    cursor.execute(
        """ insert into registro(estudiante_id, materia_id)
			values (%s,%s); 
        """,
        (id_estudiante, id_materia)
    )
    for fila in cursor:
        print(fila)

    cursor.close()
    print("consulta terminada")
#añadirmateria('4', '2')

def verMisMaterias(id_estudiante):
    cursor= connection.cursor()
    cursor.execute(
        """ select r.estudiante_id , e.snombre , e.sappaterno , m.snombre 
            from registro r 
            join estudiante e 
            on r.estudiante_id = e.ci_id 
            left join materia m 
            on r.materia_id = m.cod_id 
            where  r.estudiante_id = %s; 
        """,
        (id_estudiante)
    )
    for fila in cursor:
        print(fila)

    cursor.close()
    print("consulta terminada")
#verMisMaterias('5')

def verMisNotas(id_estudiante, nombreMateria):
    cursor= connection.cursor()
    cursor.execute(
        """select e.ci_id , e.snombre , e.sappaterno, m.snombre, v.snombre  , n.nota 
            from registro r 
            join estudiante e 
            on r.estudiante_id = e.ci_id 
            join notas n 
            on n.registro_id =r.registro_id
            join materia m 
            on r.materia_id = m.cod_id 
            join evaluacion v
            on n.evaluacion_id = v.evaluacion_id 
            where e.ci_id = %s and  m.snombre  = %s; 
        """,
        (id_estudiante, nombreMateria)
    )
    for fila in cursor:
        print(fila)

    cursor.close()
    print("consulta terminada")
#verMisNotas(4, 'Programacion I')