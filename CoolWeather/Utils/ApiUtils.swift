//
//  ApiUtils.swift
//  CoolWeather
//
//  Created by RND on 2021/1/14.
//

import UIKit
import Alamofire


//请求成功
typealias ResponseSuccess = (_ response: Data) -> Void

//请求成功
typealias ResponseSuccessString = (_ response: String) -> Void

//请求失败
typealias ResponseFail = (_ error: String) -> Void
//网络状态
typealias NetworkStatues = (_ NetworkStatus: Int32) -> Void
//进度条H
typealias ProgressBlock = (_ progress: Progress) -> Void


@objc enum NetworkStatus: Int32{
    case unknown          = -1 //未知网络
    case notReachable     = 0 //网络无连接
    case wan              = 1 //2，3，4G网络
    case wifi             = 2 //wifi网络
}

class ApiUtils: NSObject {
    
    //单列模式
    static let shared = ApiUtils()
    
    private var sessionManager: Session?
    
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        //请求超时60秒
        configuration.timeoutIntervalForRequest = 60
        sessionManager = Session.init(configuration: configuration, delegate: SessionDelegate.init(), serverTrustManager: nil)
    }
    
    ///当前网络状态
    private var mNetworkStatus: NetworkStatus = NetworkStatus.wifi
    
    
    /// 调用Get请求的时候
    /// 需要使用的方法为 UrlEncoding
    /// 如果不使用将会返回请求错误这是单独封装的代码
    
    public func netWork(url: String,
                        method:HTTPMethod,
                        params: [String: Any]?,
                        headers: HTTPHeaders,
                        ecoding: ParameterEncoding,
                        success: @escaping ResponseSuccess,
                        error: @escaping ResponseFail) {
        requestWith(url: url,
                    httpMethod: method,
                    params: params,
                    headers: headers,
                    ecoding: ecoding,
                    success: success,
                    error: error)
    }
    
    /// 用于上传和下载
    /// 返回值必须要
    public func netWorkUD(
        url:String,
        fileName:String,
        method: String,
        success: @escaping ResponseSuccessString,
        progress: @escaping ProgressBlock,
        error: @escaping ResponseFail){
        requestWithUD(url: url, fileName: fileName, method: method, success: success, progress: progress, error: error)
    }
    
    
    private func requestWithUD(
                            url: String,
                            fileName:String,
                            method: String,
                            success: @escaping ResponseSuccessString,
                            progress: @escaping ProgressBlock,
                            error: @escaping ResponseFail) {
        let data = Data("data".utf8)
        switch method {
            case "UPLOAD":
                manageUpload(data: data, url: url, success: success, err: error, progress: progress)
                break
            case "DOWNLOAD":
                manageDownload(url: url, fileName: fileName, success: success, err: error, progress: progress)
                break
            default:
                break
        }
    }
    

    private func requestWith(url: String,
                            httpMethod: HTTPMethod,
                            params: [String: Any]?,
                            headers: HTTPHeaders,
                            ecoding: ParameterEncoding,
                            success: @escaping ResponseSuccess,
                            error: @escaping ResponseFail) {
        
        //ParameterEncoding
        // JSONEncoding.default
        // URLEncoding.default
        switch httpMethod {
            case .get:
                manageGet(url: url, params: params, headers:headers,ecoding:ecoding,success: success, err: error)
                break
            case .post:
                managePost(url: url, params: params, headers:headers,ecoding:ecoding, success: success, err: error)
                break
            case .put:
                managePut(url: url, params: params, headers:headers,ecoding:ecoding, success: success, err: error)
                break
            case .delete:
                manageDelete(url: url, params: params, headers:headers,ecoding:ecoding, success: success, err: error)
                break
            default:
                break
        }
    }
    
    
    /// 注意使用 post方法的时候更改
    /// 注意使用JSONEncoding.default
    
    private func managePost(url: String,
                            params: [String: Any]?,
                            headers: HTTPHeaders,
                            ecoding:ParameterEncoding,
                            success: @escaping ResponseSuccess,
                            err: @escaping ResponseFail) {
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: ecoding,
                   headers: headers).responseJSON { (response) in
                    switch response.result {
                    case .success:
                        //let json = String(data: response.data!, encoding: String.Encoding.utf8)
                        //success(json ?? "")
                        success(response.data!)
                    case .failure(let error):
                        err(ApiError.apiError(with: error as NSError).localizedDescription)
                    }
        }
    }
    
    
    /// 请求的Get方法
    /// 注意使用 URLEncoding.deault
    
    private func manageGet(url: String,
                           params: [String: Any]?,
                           headers: HTTPHeaders,
                           ecoding:ParameterEncoding,
                           success: @escaping ResponseSuccess,
                           err: @escaping ResponseFail) {
        //请求头信息
        AF.request(url,
                   method: .get,
                   parameters: params,
                   encoding: ecoding,
                   headers: headers).responseJSON { (response) in
                    switch response.result {
                    case .success:
                        //let json = String(data: response.data!, encoding: String.Encoding.utf8)
                        //success(json ?? "")
                        success(response.data!)
                    case .failure(let error):
                        err(ApiError.apiError(with: error as NSError).localizedDescription)
                    }
        }
    }
    
    
    /// Put方法
    /// 用于Put方法的获取
    
    private func managePut(url: String,
                           params: [String: Any]?,
                           headers: HTTPHeaders,
                           ecoding:ParameterEncoding,
                           success: @escaping ResponseSuccess,
                           err: @escaping ResponseFail) {
        //请求头信息
        AF.request(url,
                   method: .put,
                   parameters: params,
                   encoding: ecoding,
                   headers: headers).responseJSON { (response) in
                    switch response.result {
                    case .success:
                        //let json = String(data: response.data!, encoding: String.Encoding.utf8)
                        //success(json ?? "")
                        success(response.data!)
                    case .failure(let error):
                        err(ApiError.apiError(with: error as NSError).localizedDescription)
                    }
        }
    }
    
    
    /// Delete用于删除方法
    private func manageDelete(url: String,
                              params: [String: Any]?,
                              headers: HTTPHeaders,
                              ecoding:ParameterEncoding,
                              success: @escaping ResponseSuccess,
                              err: @escaping ResponseFail) {
        //请求头信息
        AF.request(url,
                   method: .delete,
                   parameters: params,
                   encoding: ecoding,
                   headers: headers).responseJSON { (response) in
                    switch response.result {
                    case .success:
                        //let json = String(data: response.data!, encoding: String.Encoding.utf8)
                        //success(json ?? "")
                        success(response.data!)
                    case .failure(let error):
                        err(ApiError.apiError(with: error as NSError).localizedDescription)
                    }
        }
    }
    
    /// 下载文件夹
    private func manageDownload(
        url:String,
        fileName:String,
        success: @escaping ResponseSuccessString,
        err: @escaping ResponseFail,
        progress: @escaping ProgressBlock){
        
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(fileName)
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        AF.download(url, to: destination).downloadProgress{ progres in
            print("Download Progress: \(progres.fractionCompleted)")
            progress(progres)
            
        }.response { response in
            debugPrint(response)
            
            if response.error == nil, let filePath = response.fileURL?.path {
                //let image = UIImage(contentsOfFile: imagePath)
                success(filePath)
            }else{
                err("Download File Failed!")
            }
        }
    }
    
    /// 上传文件夹
    /// 用于上传文件
    private func manageUpload(
        data:Data,
        url:String,
        success: @escaping ResponseSuccessString,
        err: @escaping ResponseFail,
        progress: @escaping ProgressBlock){
        AF.upload(data, to: url).uploadProgress { progres in
            print("Upload Progress: \(progres.fractionCompleted)")
            progress(progres)
        }.responseJSON { response in
            switch response.result {
            case .success:
                let json = String(data: response.data!, encoding: String.Encoding.utf8)
                success(json ?? "")
                //success(response.data!)
            case .failure(let error):
                err(ApiError.apiError(with: error as NSError).localizedDescription)
            }
        }
    }
}

enum ApiError: Error {
    /// 普通的错误信息
    case error(errorMessage: String)
    /// 数据不是json格式
    case dataJSON(errorMessage: String)
    /// 数据不匹配
    case dataMatch(errorMessage: String)
    /// 数据为空
    case dataEmpty(errorMessage: String)
    /// 网络错误
    case netError(errorMessage: String)
    /// 网络错误的信息打印
    ///
    /// - Parameter error: 错误信息
    /// - Returns: 网络错误处理
    static func apiError(with error: NSError) -> ApiError {
        print("This error message is \(error)")
        if error.domain == "Alamofire.AFError" {
            //处理自带的错误
            if error.code == 4 {
                return ApiError.dataEmpty(errorMessage: "数据为空")
            }
        }
        return ApiError.netError(errorMessage: "未知网络错误")
    }
}


