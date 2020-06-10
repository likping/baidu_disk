import "./Interfaces/FileStore.dart";
import "./BdDiskApiClient.dart";
import "./DiskFile.dart";
class BdDiskFileStore extends FileStore{
  final BdDiskApiClient apiClient;
  BdDiskFileStore({BdDiskApiClient apiClient}):this.apiClient=apiClient??BdDiskApiClient();
  Future<List<DiskFile>> list(String dir,{String order="name",int start=0,int limit=1000}){
    return apiClient.getListFile(dir,order:order,start: start,limit: limit);
  }
  Future<List<DiskFile>> search(String key,{String dir='/',int recursion=0,int page=1,int num=1000}){
    return apiClient.getSearchFile(key,dir: dir,recursion:recursion.toString(),page: page,num: num);
  }
  static void sortFiles(List<DiskFile>files,String order){
    print(files);
  }
}