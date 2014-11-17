## Params Variables
The `params` object provides you access to all params submitted to the endpoint
with the addition of some useful helpers.  This includes:

* URL Query String Params
* Payload data sent in a POST, PUT, PATCH, or DELETE call.

### Params Dump
The `params.dump` value provides a JSON representation of values submitted to
your scrap endpoint.

#### Example
##### Template
```
{{ params.dump }}
```

##### POST Request to `/johnwayne/api/echo?ilike=pie`
```javascript
{
  "hey": "you guise"
}
```

##### Response
```javascript
{
  "hey": "you guise", // from JSON POST
  "ilike": "pie"      // from URL Query
}
```
