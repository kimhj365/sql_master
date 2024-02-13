-- ���� ����(�ӽü���) => ���÷� Ǯ�� ��
SET SERVEROUTPUT ON;

-- PL/SQL
-- BEGIN~END : ��
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, World!');
END;
/   
-- / : �ش� �� ������, ���� ��ɾ�(�ʼ�) => ������ ���ٷ� ǥ��


DECLARE
    -- DECLARE(�����): ���� �� ����
    -- NUMBER(9,2): �� ���� 9�ڸ� = �Ǽ� 7�ڸ� + �Ҽ� 2�ڸ�
    -- ġȯ���� &: �������ϱ� �� �̿ϼ� ���� => ġȯ���� �ذ� �� ������
    --            �� ��ġ ������� ��� ����
    v_annual NUMBER(9,2) := &����;
    -- TYPE: �̹� �����ϴ� ����/���̺� ����
    v_sal v_annual%TYPE;
    
BEGIN
    -- BEGIN(�����)
    -- ���� ������ ���� �����ݷ�
    v_sal := v_annual/12;
    DBMS_OUTPUT.PUT_LINE('The monthly salary is ' || TO_CHAR(v_sal));

END;
/
-- ��ø ���
DECLARE
    v_weight NUMBER(3) := 600;
    v_message VARCHAR2(255):='Product 10012';
    v_new_locn VARCHAR2(50);
BEGIN
    DECLARE
        v_weight NUMBER(7,2) := 50000;
        v_message VARCHAR2(255) := 'Product 11001';
        v_new_locn VARCHAR2(50) := 'Europe';
    BEGIN
        v_weight := v_weight + 1;
        v_new_locn := 'Western ' || v_new_locn;
        DBMS_OUTPUT.PUT_LINE(v_weight);
        DBMS_OUTPUT.PUT_LINE(v_message);
        DBMS_OUTPUT.PUT_LINE(v_new_locn);
    END;

    v_weight := v_weight + 1;
    v_message := v_message || ' is in stock';
    v_new_locn := 'Western ' || v_new_locn;
    DBMS_OUTPUT.PUT_LINE(v_weight);
    DBMS_OUTPUT.PUT_LINE(v_message);
    DBMS_OUTPUT.PUT_LINE(v_new_locn);
END;
/

-- ��ø��� Sample
DECLARE
    v_sal NUMBER(7,2) := 60000;
    v_comm v_sal%TYPE := v_sal * .20;
    v_message VARCHAR2(255) := ' eligible for commission';
BEGIN
    DBMS_OUTPUT.PUT_LINE('v_sal ' || v_sal);                        -- v_sal 60000
    DBMS_OUTPUT.PUT_LINE('v_comm ' || v_comm);                      -- v_comm 12000
    DBMS_OUTPUT.PUT_LINE('v_message ' || v_message);                -- v_message  eligible for commission
    DBMS_OUTPUT.PUT_LINE('================================');       -- ================================
    DECLARE 
        v_sal NUMBER(7,2) := 50000;
        v_comm v_sal%TYPE := 0;
        v_total_comp NUMBER(7,2) := v_sal + v_comm;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('v_sal ' || v_sal);                    -- v_sal 50000
        DBMS_OUTPUT.PUT_LINE('v_comm ' || v_comm);                  -- v_comm 0 
        DBMS_OUTPUT.PUT_LINE('v_message ' || v_message);            -- v_message  eligible for commission
        DBMS_OUTPUT.PUT_LINE('v_total_comp ' || v_total_comp);      -- v_total_comp 50000
        DBMS_OUTPUT.PUT_LINE('================================');   -- ================================
        v_message := 'CLERK not' || v_message;
        v_comm := v_sal * .30;
    END;
    DBMS_OUTPUT.PUT_LINE('v_sal ' || v_sal);                        -- v_sal 60000
    DBMS_OUTPUT.PUT_LINE('v_comm ' || v_comm);                      -- v_comm 12000
    DBMS_OUTPUT.PUT_LINE('v_message ' || v_message);                -- v_message CLERK not eligible for commission
    DBMS_OUTPUT.PUT_LINE('================================');       -- ================================
    v_message := 'SALESMAN ' || v_message;
    DBMS_OUTPUT.PUT_LINE('v_message ' || v_message);                -- v_message SALESMAN CLERK not eligible for commission
END;
/


-- PL/SQL�� SQL��
-- SELECT��
-- : ���� �ʿ� => DECLARE�� �ʿ�
DECLARE
    v_eid   employees.employee_id%type;
    v_ename VARCHAR2(100);
BEGIN
    SELECT employee_id, last_name
    INTO   v_eid, v_ename   -- ���� ���� = SELECT�� Į�� ��
    FROM   employees
    WHERE  employee_id = &�����ȣ;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || v_eid);
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || v_ename);
END;
/
