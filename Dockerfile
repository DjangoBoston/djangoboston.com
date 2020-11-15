
From python:3.8

RUN mkdir -p /opt/services/djangoapp/src
WORKDIR /opt/services/djangoapp/src

# RUN pip install Django==3.1.3
# RUN pip install gunicorn==20.0.4
#RUN pip install psycopg2==2.8.6


#COPY djangoboston /opt/services/djangoapp/src
COPY djangoboston/ .

# Install dependencies
RUN pip install -r requirements/base.txt

# -jlb RUN pip install -r ./djangoboston/requirements/base.txt

EXPOSE 8000

CMD ["gunicorn", "--chdir", "djangoboston", "--bind", ":8000", "djangoboston.wsgi:application"]

