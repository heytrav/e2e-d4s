from behave import *
import requests


@given('I send a GET request to {protocol}://{host}:{port}{endpoint}')
def step_impl(context, protocol, host, port, endpoint):
    url = "%s://%s:%s%s" % (protocol, host, port, endpoint)
    context.response = requests.get(url)


@then('I should receive a {status_code} response')
def step_impl(context, status_code):
    print("response: {!r}".format(context.response.status_code))
    print("status_code: %s" % status_code)
    assert int(context.response.status_code) == int(status_code)
