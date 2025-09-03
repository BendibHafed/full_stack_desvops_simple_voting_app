def test_health(client):
    resp = client.get('/healthz')
    assert resp.status_code == 200
    assert resp.get_json()['status'] == 'ok'


def test_vote_flow(client):
    # get polls
    resp = client.get('/api/polls')
    polls = resp.get_json()
    assert len(polls) == 1
    pid = polls[0]['id']

    # get choices
    resp = client.get(f'/api/polls/{pid}/choices')
    choices = resp.get_json()
    assert len(choices) >= 2
    cid = choices[0]['id']

    # vote
    resp = client.post(f'/api/polls/{pid}/vote', json={'choice_id': cid})
    assert resp.status_code == 200

    # verify votes incremented
    resp = client.get(f'/api/polls/{pid}/choices')
    choices2 = resp.get_json()
    voted = next(c for c in choices2 if c['id'] == cid)
    assert voted['votes'] == 1
