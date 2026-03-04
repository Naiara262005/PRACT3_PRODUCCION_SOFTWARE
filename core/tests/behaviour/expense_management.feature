Feature: Gestión de gastos
  Como estudiante
  Quiero registrar mis gastos
  Para controlar cuánto dinero gasto

  Scenario: Crear un gasto y comprobar cual es el total que llevo gastado
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado Café
    Then el total de dinero gastado debe ser 5 euros

  Scenario: Eliminar un gasto y comprobar cual es el total que llevo gastado
    Given un gestor con un gasto de 5 euros
    When elimino el gasto con id 1
    Then debe haber 0 gastos registrados

  Scenario: Crear y eliminar un gasto y comprobar que no he gastado dinero
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado Café
    And elimino el gasto con id 1
    Then debe haber 0 gastos registrados

  Scenario: Crear dos gastos diferentes y comprobar que el total que llevo gastado es la suma de ambos
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado Café
    And añado un gasto de 10 euros llamado Comida
    Then el total de dinero gastado debe ser 15 euros

  Scenario: Crear tres gastos diferentes que sumen 30 euros hace que el total sean 30 euros
    Given un gestor de gastos vacío
    When añado un gasto de 10 euros llamado A
    And añado un gasto de 10 euros llamado B
    And añado un gasto de 10 euros llamado C
    Then el total de dinero gastado debe ser 30 euros

  Scenario: Crear tres gastos de 10, 30, 30 euros y elimino el ultimo gasto la suma son 40 euros
    Given un gestor de gastos vacío
    When añado un gasto de 10 euros llamado A
    And añado un gasto de 30 euros llamado B
    And añado un gasto de 30 euros llamado C
    And elimino el gasto con id 3
    Then el total de dinero gastado debe ser 40 euros

  Scenario: Crear tres gastos de 10, 30, 30 euros y elimino el ultimo gasto la suma son 40 euros
    Given un gestor de gastos vacío
    When añado un gasto de 10 euros llamado A
    And añado un gasto de 30 euros llamado B
    And añado un gasto de 30 euros llamado C
    And elimino el gasto con id 3
    Then el total de dinero gastado debe ser 40 euros
  
  Scenario: Actualizar un gasto existente cambia el total
    Given un gestor con un gasto de 10 euros llamado "Cena"
    When actualizo el gasto con id 1 con nuevo título "Cena Gala" y monto 50
    Then el total de dinero gastado debe ser 50 euros
    And debe haber 1 gastos registrados

  Scenario: Comprobar el total de un mes específico
    Given un gestor de gastos vacío
    When añado un gasto de 10 euros llamado "Enero 1" con fecha "2026-01-10"
    And añado un gasto de 20 euros llamado "Enero 2" con fecha "2026-01-15"
    And añado un gasto de 5 euros llamado "Febrero" con fecha "2026-02-01"
    Then el mes "2026-01" debe sumar 30 euros
    And el mes "2026-02" debe sumar 5 euros

  Scenario: Verificar que los nombres de los gastos en la lista son correctos
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado Café
    And añado un gasto de 10 euros llamado Comida
    Then el primer gasto de la lista debe llamarse "Café"
    And el segundo gasto de la lista debe llamarse "Comida"
