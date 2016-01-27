from setuptools import setup, find_packages

setup (
    name             = "jangl-integrations-email",
    version          = "0.1",
    description      = ("Accept new integrations via email, and "
                        "set up tasks in Phabricator."),
    packages         = find_packages(),
    install_requires = ["Flask==0.10.1",
                        "mandrill==1.0.57",
                        "phabricator==0.4.0",
                        "python-slugify==1.1.4"],
    entry_points     = {'console_scripts':
                        ['run-server = server:main']}
)
