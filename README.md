# Social-post

How to Run <br>
1] Clone the repo <br>
2] npm i <br>
3] npm start <br>

# Database

1] [Table script](https://github.com/ashishbakliwal7/social-post/blob/master/social_network_post.sql) <br>
2] [Stored procedures](https://github.com/ashishbakliwal7/social-post/blob/master/social_network_routines.sql) <br>

# Rest Apis

## Get list of post's
### Request

`GET /Post`

    curl -i -H 'Accept: application/json' http://localhost:4000/post?rows=2&offset=0&search&id

### Supported queries

    id : Get by Id;
    search = Search by title;
    offset = Skip rows;
    rows = Limit rows;
    sortCol = Sort by title;
    sortDir = Direction ascending or descending
    countOnly = Count of all rows;

    
     

### Response

    "data": [
        {
            "id": 1,
            "title": "first post",
            "content": "hello",
            "created_by": 1,
            "created_at": "2022-03-12T03:08:54.000Z",
            "updated_at": "2022-03-12T03:08:54.000Z"
        }
    ]

## Get Post by Id
### Request

`GET /Post/:id`

    curl -i -H 'Accept: application/json' http://localhost:4000/post/:id  
     

### Response
   
    "data":{
            "id": 1,
            "title": "first post",
            "content": "hello",
            "created_by": 1,
            "created_at": "2022-03-12T03:08:54.000Z",
            "updated_at": "2022-03-12T03:08:54.000Z"
        }

## Create a new Post

### Request

`POST /post`

    curl --location --request POST 'http://localhost:4000/post' \
    --header 'Content-Type: application/json' \
    --data-raw '{
    "title" : "second post",
    "content" : "hello"
    }'

### Response

    {
    "message": {
        "fieldCount": 0,
        "affectedRows": 1,
        "insertId": 0,
        "serverStatus": 2,
        "warningCount": 0,
        "message": "",
        "protocol41": true,
        "changedRows": 0
        }
    }

## Update a new Post

### Request

`PUT /post/:id`

    curl --location --request PUT 'http://localhost:4000/post/:id' \
    --header 'Content-Type: application/json' \
    --data-raw '{
    "title" : "second post",
    "content" : "hello"
    }'

### Response

    {
    "message": {
        "fieldCount": 0,
        "affectedRows": 1,
        "insertId": 0,
        "serverStatus": 2,
        "warningCount": 0,
        "message": "",
        "protocol41": true,
        "changedRows": 0
        }
    }

## Delete a new Post

### Request

`Delete /post/:id`

    curl --location --request DELETE 'http://localhost:4000/post/:id' \

### Response

    {
    "message": {
        "fieldCount": 0,
        "affectedRows": 1,
        "insertId": 0,
        "serverStatus": 2,
        "warningCount": 0,
        "message": "",
        "protocol41": true,
        "changedRows": 0
        }
    }



