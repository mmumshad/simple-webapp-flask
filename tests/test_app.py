import pytest

# Adjust this import to match how your app is structured.
# Common patterns:
#   from app import app                (if app.py has: app = Flask(__name__))
#   from app import create_app; app = create_app()
from app import app as flask_app


@pytest.fixture
def client():
    flask_app.config["TESTING"] = True
    with flask_app.test_client() as client:
        yield client


def test_app_exists():
    assert flask_app is not None


def test_home_page_status_code(client):
    response = client.get("/")
    # Adjust expected status/content to match your actual home route
    assert response.status_code in (200, 404)