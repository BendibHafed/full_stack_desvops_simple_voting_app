from flask import Blueprint, jsonify, request, render_template
from backend.app import db
from backend.app.models import Poll, Choice

bp = Blueprint("main", __name__)


@bp.route("/healthz")
def healthz():
    return jsonify(status="ok")


@bp.route("/")
def index():
    return render_template("index.html")


@bp.route("/api/polls")
def api_polls():
    polls = Poll.query.all()
    data = [{"id": p.id, "question": p.question} for p in polls]
    return jsonify(data)


@bp.route("/api/polls/<int:poll_id>/choices")
def api_choices(poll_id):
    choices = Choice.query.filter_by(poll_id=poll_id).all()
    data = [{"id": c.id, "text": c.text, "votes": c.votes} for c in choices]
    return jsonify(data)


@bp.route("/api/polls/<int:poll_id>/vote", methods=["POST"])
def api_vote(poll_id):
    payload = request.get_json() or {}
    choice_id = payload.get("choice_id")
    if not choice_id:
        return jsonify({"error": "missing choice ID"}), 400
    choice = Choice.query.filter_by(id=choice_id, poll_id=poll_id).first()
    if not choice:
        return jsonify({"error": "invalid choice ID"})
    # increment and commit
    choice.votes = choice.votes + 1
    db.session.commit()
    return jsonify(
        {"status": "ok",
         "choice_id": choice.id,
         "votes": choice.votes}
         )
