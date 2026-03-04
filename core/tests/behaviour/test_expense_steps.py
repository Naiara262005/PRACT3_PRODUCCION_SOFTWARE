from datetime import date, datetime 
import pytest
from pytest_bdd import scenarios, given, when, then, parsers

from core.expense_service import ExpenseService
from core.in_memory_expense_repository import InMemoryExpenseRepository

scenarios("./expense_management.feature")

@pytest.fixture
def context():
    repo = InMemoryExpenseRepository()
    service = ExpenseService(repo)
    return {"service": service, "db": repo}


@given(parsers.parse("un gestor de gastos vacío"))
def empty_manager(context):
    pass

@given(parsers.parse("un gestor con un gasto de {amount:d} euros"))
def manager_with_one_expense(context, amount):
    context["service"].create_expense(
        title="Gasto inicial", amount=amount, description="", expense_date=date.today()
    )

@when(parsers.parse("añado un gasto de {amount:d} euros llamado {title}"))
def add_expense(context, amount, title):
    context["service"].create_expense(
        title=title, amount=amount, description="", expense_date=date.today()
    )

@when(parsers.parse("elimino el gasto con id {expense_id:d}"))
def remove_expense(context, expense_id):
    context["service"].remove_expense(expense_id)

@then(parsers.parse("el total de dinero gastado debe ser {total:d} euros"))
def check_total(context, total):
    assert context["service"].total_amount() == total

@then(parsers.parse("{month_name} debe sumar {expected_total:d} euros"))
def check_month_total(context, month_name, expected_total):
    totals = context["service"].total_by_month()
    total_actual = totals.get(month_name, 0)
    assert total_actual == expected_total

@then(parsers.parse("debe haber {expenses:d} gastos registrados"))
def check_expenses_length(context, expenses):
    total = len(context["db"]._expenses)
    assert expenses == total



@given(parsers.parse('un gestor con un gasto de {amount:d} euros llamado "{title}"'))
def manager_with_named_expense(context, amount, title):
    context["service"].create_expense(title, amount, "", date.today())

@when(parsers.parse('añado un gasto de {amount:d} euros llamado "{title}" con fecha "{date_str}"'))
def add_expense_with_date(context, amount, title, date_str):
    fecha = datetime.strptime(date_str, "%Y-%m-%d").date()
    context["service"].create_expense(title, amount, "", fecha)

@when(parsers.parse('actualizo el gasto con id {expense_id:d} con nuevo título "{title}" y monto {amount:d}'))
def update_expense_step(context, expense_id, title, amount):
    context["service"].update_expense(expense_id=expense_id, title=title, amount=amount)

@then(parsers.parse('el mes "{month_name}" debe sumar {expected_total:d} euros'))
def check_month_total_bonus(context, month_name, expected_total):
    totals = context["service"].total_by_month()
    assert totals.get(month_name, 0) == expected_total

@then(parsers.parse('el primer gasto de la lista debe llamarse "{title}"'))
def check_first_title(context, title):
    assert context["service"].list_expenses()[0].title == title

@then(parsers.parse('el segundo gasto de la lista debe llamarse "{title}"'))
def check_second_title(context, title):
    assert context["service"].list_expenses()[1].title == title