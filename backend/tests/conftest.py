import pytest
from backend.app import create_app, db
from backend.app.models import Poll, Choice


@pytest.fixture
def app():
    app = create_app("testing")

    with app.app_context():
        db.create_all()

        # Seed test data
        poll = Poll(question="Best programming language?")
        db.session.add(poll)
        db.session.commit()

        choice1 = Choice(poll_id=poll.id, text="Python", votes=0)
        choice2 = Choice(poll_id=poll.id, text="JavaScript", votes=0)
        db.session.add_all([choice1, choice2])
        db.session.commit()

        yield app

        db.drop_all()


@pytest.fixture
def client(app):
    return app.test_client()
