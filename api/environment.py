import os

os.environ['DJANGO_SETTINGS_MODULE'] = 'catalystinnovation.settings'

def before_all(context):
    """TODO: Docstring for before_all.

    :context: TODO
    :returns: TODO

    """
    from django.core.management import setup_environ
    from catalystinnovation import settings
    setup_environ(settings)

    from django.test.simple import DjangoTestSuiteRunner
    context.runner = DjangoTestSuiteRunner()

    import wsgi_intercept
    from django.core.handlers.wsgi import WSGIHandler
    host = context.host = 'api'
    port = context.port = getattr(settings, 'TESTING_MECHANIZE_INTERCEPT_PORT', 17681)
    wsgi_intercept.add_wsgi_intercept(host, port, WSGIHandler)

    def browser_url(url):
        """TODO: Docstring for browser_url.

        :url: TODO
        :returns: TODO

        """
        return urlparse.urljoin('http://%s:%d/' % (host, port), url)
    context.browser_url = browser_url



