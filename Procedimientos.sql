-- Actualizar los datos de un registro en la tabla dept.
-- no_dept: numero del departamento.
-- dept_name: nuevo nombre que se asignara al registro.
-- loca: nueva localizacion que se asignara al registro.

create or replace PROCEDURE Update_depto(
      no_dept dept.deptno%TYPE,
      dept_name dept.dname%TYPE,
      loca dept.loc%TYPE)
IS
    out_of_range EXCEPTION;
    invalid_arg EXCEPTION;
    incorrect_type EXCEPTION;
    unique_key EXCEPTION;
    too_large_value EXCEPTION;
    null_value EXCEPTION;
    inexistent_dept EXCEPTION;

    PRAGMA EXCEPTION_INIT(out_of_range, -12899);
    PRAGMA EXCEPTION_INIT(invalid_arg, -01722);
    PRAGMA EXCEPTION_INIT(incorrect_type, -00932);
    PRAGMA EXCEPTION_INIT(unique_key, -00001);
    PRAGMA EXCEPTION_INIT(too_large_value, -01438);
    PRAGMA EXCEPTION_INIT(null_value,-01400);
BEGIN
      UPDATE dept
      SET dname = dept_name, loc = loca
      WHERE deptno = no_dept;
      
      IF SQL%ROWCOUNT = 0
    THEN
        RAISE inexistent_dept;
    END IF;
      
      COMMIT;
EXCEPTION
      WHEN inexistent_dept THEN
            RAISE_APPLICATION_ERROR(-20010, 'ERROR: El departamento no existe.');
      WHEN out_of_range THEN
            RAISE_APPLICATION_ERROR(-20020, 'ERROR: Parametro fuera de rango.');
      WHEN invalid_arg THEN
            RAISE_APPLICATION_ERROR(-20030, 'ERROR: Dato no valido.');
      WHEN incorrect_type THEN
            RAISE_APPLICATION_ERROR(-20040, 'ERROR: Dato incorrecto.');
      WHEN too_large_value THEN
            RAISE_APPLICATION_ERROR(-20060, 'ERROR: Valor excede el tamano permitido.');      
      WHEN null_value THEN
            RAISE_APPLICATION_ERROR(-20070, 'ERROR: Valores nulos no permitidos.'); 
END;


-- Actualizar los datos de un registro en la tabla emp.
-- no_emp: numero del empleado.
-- emp_name: nuevo nombre que se asignara al registro.
-- emp_job: nuevo puesto que se asignara al registro.
-- emp_mgr: nuevo numero de empleado del jefe que se asignara al registro.
-- emp_hiredate: nueva fecha de contratacion que se le asignara al registro.
-- emp_sal: nuevo salario que se asignara al registro.
-- emp_comm: nueva comision que se asignara al registro.
-- emp_deptno: nuevo numero de departamento que se asignara al registro.

create or replace PROCEDURE Update_emp(
      no_emp emp.empno%TYPE,
      emp_name emp.ename%TYPE,
      emp_job emp.job%TYPE,
      emp_mgr emp.mgr%TYPE,
      emp_hiredate emp.hiredate%TYPE,
      emp_sal emp.sal%TYPE,
      emp_comm emp.comm%TYPE,
      emp_deptno emp.deptno%TYPE)
IS
    out_of_range EXCEPTION;
    invalid_arg EXCEPTION;
    incorrect_type EXCEPTION;
    unique_key EXCEPTION;
    foreign_key EXCEPTION;
    too_large_value EXCEPTION;
    null_value EXCEPTION;
    inexistent_emp EXCEPTION;

    PRAGMA EXCEPTION_INIT(out_of_range, -12899);
    PRAGMA EXCEPTION_INIT(invalid_arg, -01722);
    PRAGMA EXCEPTION_INIT(incorrect_type, -00932);
    PRAGMA EXCEPTION_INIT(unique_key, -00001);
    PRAGMA EXCEPTION_INIT(foreign_key, -02291);
    PRAGMA EXCEPTION_INIT(too_large_value, -01438);
    PRAGMA EXCEPTION_INIT(null_value,-01400);
BEGIN
      UPDATE emp
      SET ename = emp_name, job = emp_job, mgr =emp_mgr, hiredate = emp_hiredate, sal=emp_sal, comm=emp_comm, deptno= emp_deptno      
      WHERE  empno= no_emp;
      
      IF SQL%ROWCOUNT = 0
    THEN
        RAISE inexistent_emp;
    END IF;
      
      COMMIT;
EXCEPTION
      WHEN inexistent_emp THEN
            RAISE_APPLICATION_ERROR(-20010, 'ERROR: El empleado no existe');
      WHEN out_of_range THEN
            RAISE_APPLICATION_ERROR(-20020, 'ERROR: Parametro fuera de rango.');
      WHEN invalid_arg THEN
            RAISE_APPLICATION_ERROR(-20030, 'ERROR: Dato no valido.');
      WHEN incorrect_type THEN
            RAISE_APPLICATION_ERROR(-20040, 'ERROR: Dato incorrecto.'); 
      WHEN foreign_key THEN
            RAISE_APPLICATION_ERROR(-20060, 'ERROR: Registro huerfano.');  
      WHEN too_large_value THEN
            RAISE_APPLICATION_ERROR(-20070, 'ERROR: Valor excede el tamano permitido.');  
      WHEN null_value THEN
            RAISE_APPLICATION_ERROR(-20070, 'ERROR: Valores nulos no permitidos.');
END;


-- Eliminar registro de la tabla dept.
-- no_dept: numero del departamento a eliminar.

create or replace PROCEDURE Delete_depto(
      no_dept dept.deptno%TYPE)
IS
    has_emps EXCEPTION;
    inexistent_dept EXCEPTION;
    
    PRAGMA EXCEPTION_INIT(has_emps, -02292);
BEGIN
      DELETE FROM dept
      WHERE deptno= no_dept;
      
      IF SQL%ROWCOUNT = 0
    THEN
        RAISE inexistent_dept;
    END IF;
      
      COMMIT;
EXCEPTION
      WHEN inexistent_dept THEN
            RAISE_APPLICATION_ERROR(-20010, 'ERROR: El departamento no existe');
      WHEN has_emps THEN
            RAISE_APPLICATION_ERROR(-20020, 'ERROR: El departamento tiene empleados asignados.');            
END;


-- Eliminar registro de la tabla emp.
-- no_emp: numero del empleado a eliminar.

create or replace PROCEDURE Delete_emp(
      no_emp emp.empno%TYPE)
IS
    inexistent_emp EXCEPTION;
BEGIN
      DELETE FROM emp
      WHERE empno = no_emp;
      
      IF SQL%ROWCOUNT = 0
    THEN
        RAISE inexistent_emp;
    END IF;
    
      COMMIT;
EXCEPTION
      WHEN inexistent_emp THEN
            RAISE_APPLICATION_ERROR(-20020, 'ERROR: El empleado no existe');        
END;


-- Agregar registro en la tabla dept
-- no_dept: numero del nuevo departamento.
-- dept_name: nombre del nuevo departamento.
-- loca: nombre de la localizacion del nuevo departamento.

create or replace PROCEDURE Add_depto(
      no_dept dept.deptno%TYPE,
      dept_name dept.dname%TYPE,
      loca dept.loc%TYPE)
IS
    out_of_range EXCEPTION;
    invalid_arg EXCEPTION;
    incorrect_type EXCEPTION;
    unique_key EXCEPTION;
    too_large_value EXCEPTION;
    null_value EXCEPTION;

    PRAGMA EXCEPTION_INIT(out_of_range, -12899);
    PRAGMA EXCEPTION_INIT(invalid_arg, -01722);
    PRAGMA EXCEPTION_INIT(incorrect_type, -00932);
    PRAGMA EXCEPTION_INIT(unique_key, -00001);
    PRAGMA EXCEPTION_INIT(too_large_value, -01438);
    PRAGMA EXCEPTION_INIT(null_value,-01400);
BEGIN
      INSERT INTO dept
      VALUES (no_dept, dept_name, loca);
      COMMIT;
EXCEPTION
      WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20010, 'ERROR: El departamento no existe.');
      WHEN out_of_range THEN
            RAISE_APPLICATION_ERROR(-20020, 'ERROR: Parametro fuera de rango.');
      WHEN invalid_arg THEN
            RAISE_APPLICATION_ERROR(-20030, 'ERROR: Dato no valido.');
      WHEN incorrect_type THEN
            RAISE_APPLICATION_ERROR(-20040, 'ERROR: Dato incorrecto.');
      WHEN unique_key THEN
            RAISE_APPLICATION_ERROR(-20050, 'ERROR: Numero de departamento ya existente.');  
      WHEN too_large_value THEN
            RAISE_APPLICATION_ERROR(-20060, 'ERROR: Valor excede el tamano permitido.'); 
      WHEN null_value THEN
            RAISE_APPLICATION_ERROR(-20070, 'ERROR: Valores nulos no permitidos.'); 
END;


-- Agregar un registro a la tabla emp
-- no_emp: numero del nuevo empleado.
-- emp_name: nombre del nuevo empleado.
-- emp_job: nombre del nuevo puesto.
-- emp_mgr: numero de empleado del jefe del nuevo empleado.
-- emp_hiredate: fecha de contratacion del nuevo empleado.
-- emp_sal: salario del nuevo empleado.
-- emp_comm: comision del nuevo empleado.
-- emp_deptno: numero del departamento del nuevo empleado.

create or replace PROCEDURE Add_emp(
      no_emp emp.empno%TYPE,
      emp_name emp.ename%TYPE,
      emp_job emp.job%TYPE,
      emp_mgr emp.mgr%TYPE,
      emp_hiredate emp.hiredate%TYPE,
      emp_sal emp.sal%TYPE,
      emp_comm emp.comm%TYPE,
      emp_deptno emp.deptno%TYPE)
IS
    out_of_range EXCEPTION;
    invalid_arg EXCEPTION;
    incorrect_type EXCEPTION;
    unique_key EXCEPTION;
    foreign_key EXCEPTION;
    too_large_value EXCEPTION;
    null_value EXCEPTION;

    PRAGMA EXCEPTION_INIT(out_of_range, -12899);
    PRAGMA EXCEPTION_INIT(invalid_arg, -01722);
    PRAGMA EXCEPTION_INIT(incorrect_type, -00932);
    PRAGMA EXCEPTION_INIT(unique_key, -00001);
    PRAGMA EXCEPTION_INIT(foreign_key, -02291);
    PRAGMA EXCEPTION_INIT(too_large_value, -01438);
    PRAGMA EXCEPTION_INIT(null_value,-01400);
BEGIN
      INSERT INTO emp 
      VALUES (no_emp, emp_name, emp_job, emp_mgr, emp_hiredate, emp_sal, emp_comm, emp_deptno);
      COMMIT;
EXCEPTION   
      WHEN out_of_range THEN
            RAISE_APPLICATION_ERROR(-20020, 'ERROR: Parametro fuera de rango.');
      WHEN invalid_arg THEN
            RAISE_APPLICATION_ERROR(-20030, 'ERROR: Dato no valido.');
      WHEN incorrect_type THEN
            RAISE_APPLICATION_ERROR(-20040, 'ERROR: Dato incorrecto.');
      WHEN unique_key THEN
            RAISE_APPLICATION_ERROR(-20050, 'ERROR: Numero de empleado ya existente.');   
      WHEN foreign_key THEN
            RAISE_APPLICATION_ERROR(-20060, 'ERROR: Departamento huerfano.');
      WHEN too_large_value THEN
            RAISE_APPLICATION_ERROR(-20070, 'ERROR: Valor excede el tamano permitido.');    
      WHEN null_value THEN
            RAISE_APPLICATION_ERROR(-20070, 'ERROR: Valores nulos no permitidos.'); 
END;


-- Encontrar el numero de empleados asignados a un departamento.
-- no_dept: numero del departamento.
-- return: numero de empleados. 

create or replace FUNCTION noEmp_depto(
      no_dept dept.deptno%TYPE)
      RETURN NUMBER
IS
    out_of_range EXCEPTION;
    PRAGMA EXCEPTION_INIT(out_of_range, -12899);

    noemp NUMBER(3) := 0;
    exist dept.dname%TYPE;
BEGIN
      SELECT dname INTO exist
      FROM dept
      WHERE deptno = no_dept;
      
      SELECT COUNT(empno) INTO noemp
      FROM emp INNER JOIN dept USING(deptno)
      WHERE deptno = no_dept;

      RETURN noemp;
EXCEPTION   
      WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20010, 'ERROR: Departamento inexistente.');
      WHEN out_of_range THEN
            RAISE_APPLICATION_ERROR(-20020, 'ERROR: Parametro fuera de rango.');
      RETURN noemp;
END noEmp_depto;


-- Buscar un registro en la tabla dept.
-- no_dept: numero del departamento buscado.
-- return: cadena de caracteres con los valores del registro en dept concatenados, separados por una coma.

create or replace FUNCTION read_dept(
    no_dept dept.deptno%TYPE)
    RETURN VARCHAR2
IS
    reg dept%ROWTYPE := NULL;
    str_reg VARCHAR2(200) := NULL;
BEGIN
    SELECT * INTO reg
    FROM dept
    WHERE deptno = no_dept;
    
    str_reg := reg.deptno || ', ' || reg.dname || ', ' || reg.loc;

    RETURN str_reg;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20100, 'ERROR: El departamento no existe.');
    RETURN str_reg;
END read_dept;


-- Buscar un registro en la tabla emp.
-- no_emp: numero del empleado a buscar.
-- return: cadena de caracteres con los valores de los campos del registro concatenados.

create or replace FUNCTION read_emp(
    no_emp emp.empno%TYPE)
    RETURN VARCHAR2
IS
    reg emp%ROWTYPE;
    str_reg VARCHAR2(200) := NULL;
BEGIN
    SELECT * INTO reg
    FROM emp
    WHERE empno = no_emp;
    
    str_reg := 'Numero de empleado: ' || reg.empno || chr(10) ||
               'Nombre: ' || reg.ename || chr(10) || 
               'Puesto: ' || reg.job || chr(10) || 
               'Numero de empleado del jefe: ' || reg.mgr || chr(10) || 
               'Fecha de contratacion: ' || reg.hiredate || chr(10) || 
               'Salario: ' || reg.sal || chr(10) ||
               'Comision: ' || reg.comm || chr(10) || 
               'Numero de departamento: ' || reg.deptno;

    RETURN str_reg;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20100, 'ERROR: El empleado no existe.');
    RETURN str_reg;
END read_emp;


























