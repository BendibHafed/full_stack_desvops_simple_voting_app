from datetime import datetime, UTC
from backend.app import db


class Poll(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    question = db.Column(db.String(255), nullable=False)
    created_at = db.Column(db.DateTime, default=lambda: datetime.now(UTC))
    choices = db.relationship(
        "Choice",
        backref="poll",
        cascade="all, delete-orphan")


class Choice(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    poll_id = db.Column(db.Integer, db.ForeignKey("poll.id"), nullable=False)
    text = db.Column(db.String(255), nullable=False)
    votes = db.Column(db.Integer, default=0)
