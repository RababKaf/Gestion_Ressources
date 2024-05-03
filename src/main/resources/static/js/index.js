$(document).ready(function(){

    let news = [
        {title: "AppelOffre1", description: "-------------------"},
        {title: "AppelOffre2", description: "--------------------"},
        {title: "AppelOffre3", description: "---------------------"},
        {title: "AppelOffre4", description: "-----------------------"},
        {title: "AppelOffre5", description: "-----------------------"},
        {title: "AppelOffre6", description: "-----------------------"},
        {title: "AppelOffre7", description: "------------------------"},
        {title: "AppelOffre8", description: "-----------------------"},
        {title: "AppelOffre9", description: "-----------------------"},
        {title: "AppelOffre10", description: "-----------------------"}
    ]
    
    let newsholder = $("#newsholder")
    
    news.map(obj => {
//        newsholder.append(`
//        <span id="singlenewsholder">
//            <span id="newstitle">${obj.title}</span>
//            <span id="newsdescription">${obj.description}</span>
//            <a href="/">Lire la suite</span>
//        </span>
//        `)
    })
  });
