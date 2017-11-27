import requests, json, sys

#message = 'ping failed'
#message = sys.argv[1]

def postSlack(message):
    payload = {'channel': '#scm-outages', 'username': 'monitoringBot', 'text': message, 'icon_emoji': ':cop:'}
    url = 'https://hooks.slack.com/services/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'
    #r = requests.post(url, data=payload)
    r = requests.post(url, data=json.dumps(payload))
    print(r.text)

if __name__ == "__main__":
    message = 'donw'
    postSlack(message)

    