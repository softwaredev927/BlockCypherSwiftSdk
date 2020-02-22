//
//  Job.swift
//  BlockCypherSwiftSdk
//
//  Created by S.Bezpalyi on 22/02/2020.
//

import Foundation

//A Job represents an analytics query set up through the Analytics API.
public struct Job: Codable {
    
    //The token that created this job.
    var token: String = ""
    
    //The engine used for the job query.
    var analytics_engine: String = ""
    
    //The time this job was created.
    var created_at: String = ""
    
    //Optional When this job was completed; only present on complete jobs.
    var completed_at: String?
    
    //true if this job is finished processing, false otherwise.
    var finished: Bool = false
    
    //true if this job has begun processing, false otherwise.
    var started: Bool = false
    
    //Unique identifier for this job, used to get job status and results.
    var ticket: String = ""
    
    //Optional URL to query job results; only present on complete jobs.
    var result_path: String = ""
    
    //Query arguments for this job.
    var args: JobArgs = JobArgs()
}


//A JobArgs represents the query parameters of a particular analytics job, used when Creating an Analytics Job and returned within a Job.
//Note that the required and optional arguments can change depending on the engine you're using; for more specifics check the Analytics Engine and Parameters section.
public struct JobArgs: Codable {
    
    //Address hash this job is querying.
    var address: String = ""
    
    //Minimal/threshold value (in satoshis) to query.
    var value_threshold: Int = 0
    
    //Limit of results to return.
    var limit: Int = 0
    
    //Beginning of time range to query.
    var start: String = ""
    
    //End of time range to query.
    var end: String = ""
    
    //Degree of connectiveness to query.
    var degree: Int = 0
    
    //IP address and port, of the form "0.0.0.0:80".
    //Ideally an IP and port combination found from another API lookup (for example, relayed_by from the Transaction Hash Endpoint)
    var source: String = ""
}

//A JobResults represents the result of a particular analytics job, returned from Get Analytics Job Results.
//Note that the results field will depend largely on the engine used.
public struct JobResult: Codable {
    
    //Current page of results.
    var page: Int = 0
    
    //true if there are more results in a separate page; false otherwise.
    var more: Bool = false
    
    //Optional URL to get the next page of results; only present if there are more results to show.
    var next_page: String?
    
    //Results of analytics job; structure of results are dependent on engine-type of query, but are generally either strings of address hashes or JSON objects.
    var results: [Job] = []
}
