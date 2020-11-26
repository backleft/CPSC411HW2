import Kitura
import Cocoa

let router = Router()
let dbObj = Database.getInstance()

//let dbObj = Database.getInstance()
//router.all("/post", middleware:BodyParser())

//router.get("",lambda)
/*
router.get("/get"){
    request,response,next in
    print("Getting HTTP GET request /get")
    let count = request.queryParameters.count
    response.send("WASSUP this site is broken for now....")
    print ("THe parameters are this many: \(count)")
    next()
    
}
router.get("/post"){
    request,response,next in
    print("Getting HTTP POST request /post")
    let body = request.body
    let data : String? = body?.asText
    response.send("The request msg body ; " + data!)
}
router.post("/new"){ request, response, next in
    let body = request.body
    if body == nil {
        try response.send("Request body is empty and please check why.").end()
        return
    }
}*/

router.all("/ClaimsService/add",middleware: BodyParser())
router.all("/"){
    request, response, next in
    response.send("Hello! Welcome to the Service")
    next()
}
router.get("/ClaimsService/getAll"){
    request, response, next in
    let pList = ClaimsDB().getAll()
    let jsonData : Data = try JSONEncoder().encode(pList)
    let jsonStr =  String(data: jsonData, encoding: .utf8)
    response.status(.OK)
    response.headers["Content-Type"] = "application/json"
    response.send(jsonStr)
    next()
}
router.post("/ClaimsService/add"){
    request, response, next in
    let body = request.body
    let jObj = body?.asJSON
    if let jDict = jObj as? [String:String]{
        if let title = jDict["title"], let date = jDict["date"],let isSolved = jDict["isSolved"]{
            //let uuid = UUID().uuidString
            //let cObj = Claims(id: uuid,title: title, date: date, isSolved: isSolved)
            let cObj = Claims(title: title, date: date, isSolved: isSolved)
            ClaimsDB().addClaim(pObj: cObj)
        }
    }
    response.send("Claim has been sent VIA postMethod")
    next()
}

router.get("/ClaimsService/add"){
    request,response,next in
    let isSolved = request.queryParameters["isSolved"]
    let date = request.queryParameters["date"]
    if let title =  request.queryParameters["title"]{
        let pObj = Claims(title: title, date: date, isSolved: isSolved)
        ClaimsDB().addClaim(pObj: pObj)
        response.send("The Claim Record inserted!")
    }
    else{
        
    }
    next()
}

//router.get("/ClaimsService/add"){
  //  request, response, next in
    
//}
//	router.get("/add"){request, response}

/*
router.all("/PersonalService/add",middleware: BodyParser())
router.get("/"){
    request, response, next in
    response.send("Hello! Welcome to the service")
    next()
}
router.get("/PersonalService/getAll"){
    request, response,next in
    let pList = PersonalDB().getAll()
    //Json Serialization
    let jsonData : Data = try JSONEncoder().encode(pList)
    //JSON array
    let jsonStr = String(data: jsonData,encoding: .utf8)
    // set Content-Type
    response.status(.OK)
    response.headers["Content-Type"] = "application/json"
    response.send(jsonStr)
    //response.send("Contents \(pList.description)")
    response.send(jsonStr)
    next()
}
router.post("/PersonalService/add"){
    request,response,next in
    let body = request.body
    let jObj = body?.asJSON
    if let jDict = jObj as? [String:String]{
        if let fn = jDict["firstName"], let ln = jDict["lastName"], let n = jDict["ssn"]{
            let pObj = Person(fn:fn, ln:ln, num:n)
            PersonalDB().addPerson(pObj: pObj)
        }
    }
    response.send("Person was inserted VIA postMEthod")
    next()
}
router.get("/PersonalService/add"){
    request,response,next in
    let fn =  request.queryParameters["FirstName"]
    let ln =  request.queryParameters["LastName"]
    if let num =  request.queryParameters["SSN"]{
        let pObj = Person(fn:fn, ln:ln, num:num)
        PersonalDB().addPerson(pObj: pObj)
        response.send("The person recorded was inserted")
    }
    else{
        
    }
    next()
}



    Tried for a couple hours to get a working iteration for part 1 of Question 3
    but I still couldn't get it to work
 
router.post("/PersonalServicce/addList"){
    request, response, next in
    let body = request.body
    let jObj = body?.asJSON
    if let jDict = jObj as? [String:String]{
        if let fn = jDict["firstName"], let ln = jDict["lastName"], let n = jDict["ssn"]{
            let pObj = Person(fn:fn, ln:ln, num:n)
            PersonalDB().addPerson(pObj: pObj)
        }
    }
    response.send("Sent via post AddList")
    next()
}
 */

Kitura.addHTTPServer(onPort: 8020 , with: router)
Kitura.run()
