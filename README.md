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

    HTTP/1.1 200 OK
    Date: Thu, 24 Feb 2011 12:36:30 GMT
    Status: 200 OK
    Connection: close
    Content-Type: application/json
    Content-Length: 2
    
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




