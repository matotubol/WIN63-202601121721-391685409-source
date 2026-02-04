package com.sulake.habbo.avatar.structure
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.class_23;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public class AvatarStructureDownload extends EventDispatcherWrapper
   {
      
      public static const STRUCTURE_DONE:String = "AVATAR_STRUCTURE_DONE";
      
      private var var_5064:IStructureData;
      
      public function AvatarStructureDownload(param1:class_40, param2:String, param3:IStructureData)
      {
         super();
         var_5064 = param3;
         if(param1.hasAsset(param2))
         {
            class_21.log("[AvatarStructureDownload] reload data for url: " + param2);
         }
         var _loc4_:URLRequest = new URLRequest(param2);
         var _loc5_:AssetLoaderStruct = param1.loadAssetFromFile(param2,_loc4_,"text/plain");
         _loc5_.addEventListener("AssetLoaderEventComplete",onDataComplete);
         _loc5_.addEventListener("AssetLoaderEventError",onDataFailed);
      }
      
      private function onDataComplete(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc4_:XML = null;
         var _loc3_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc3_ == null || _loc3_.assetLoader == null)
         {
            return;
         }
         try
         {
            _loc2_ = _loc3_.assetLoader.content as String;
            if(_loc2_ == null || _loc2_.length == 0)
            {
               class_23.error("Could not load avatar structure, got empty data from URL " + _loc3_.assetLoader.url + " data length = " + _loc2_.length + ".",false,1);
            }
            _loc4_ = new XML(_loc2_);
         }
         catch(e:Error)
         {
            class_21.log("[AvatarStructureDownload] Error: " + e.message);
            return;
         }
         if(_loc4_ == null)
         {
            class_21.log("[AvatarStructureDownload] XML error: " + _loc3_ + " not valid XML");
            return;
         }
         var_5064.appendXML(_loc4_);
         dispatchEvent(new Event("AVATAR_STRUCTURE_DONE"));
      }
      
      private function onDataFailed(param1:Event) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         var _loc3_:String = "";
         if(_loc2_ != null && _loc2_.assetLoader != null)
         {
            _loc3_ = _loc2_.assetLoader.url;
         }
         HabboWebTools.logEventLog("figurepartlist download error " + _loc3_);
         class_23.error("Could not load avatar structure. Failed to get data from URL " + _loc3_,true,1);
      }
   }
}

