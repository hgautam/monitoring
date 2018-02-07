#!/usr/bin/python

import subprocess

def pingOk(sHost):
    try:
        print('pinging', sHost)
        output = subprocess.check_output("ping -{} 1 {}".format( 'c', sHost), shell=True)
        #print(output)

    except Exception, e:
        #print(e)
        return False

    return True

def startPinging():
    errors = []
    f = open('hosts', 'rU')
    for host in f:
        result = pingOk(host.rstrip())
        #print(result)
        if result:
            print('Success')
        else:
            errors.append(host)
            print('Failure')
    f.close()

    if len(errors) > 0:
        print('host[s] not responding', errors)
        from slackApiPost import postSlack
        for failedhost in errors:
            print ('host is ' + failedhost)
            postSlack('<!here> ' + failedhost.rstrip() + ' is down!!')
        exit(1)


if __name__ == "__main__":
    startPinging()