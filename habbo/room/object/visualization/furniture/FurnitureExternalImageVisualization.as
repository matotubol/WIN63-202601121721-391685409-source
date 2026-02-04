package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.room.object.visualization.data.ExtraDataManager;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import package_69.JSONDecoder;
   
   public class FurnitureExternalImageVisualization extends class_2189
   {
      
      private var var_3836:Boolean;
      
      private var var_1639:String;
      
      private var var_3406:String;
      
      private var var_989:String;
      
      private var var_3318:Boolean = false;
      
      private var var_1810:String = "";
      
      private var var_3837:String;
      
      public function FurnitureExternalImageVisualization()
      {
         super();
         hasOutline = true;
      }
      
      override public function setExternalBaseUrls(param1:String, param2:String, param3:Boolean) : void
      {
         var_1639 = param1;
         var_3406 = param2;
         var_3836 = param3;
      }
      
      override protected function getThumbnailURL() : String
      {
         if(!object || var_1639 == "disabled" || var_989 == "REJECTED")
         {
            return null;
         }
         if(var_989)
         {
            return var_989;
         }
         var _loc1_:String = object.getModel().getString("furniture_data");
         if(_loc1_ == null)
         {
            return null;
         }
         try
         {
            if(object.getType().indexOf("external_image_wallitem_poster") != -1)
            {
               var_1810 = "";
            }
            else
            {
               var_1810 = "postcards/selfie/";
            }
            var _loc2_:String = getJsonValue(_loc1_,"id",null);
            var _loc3_:String = getJsonValue(_loc1_,"w","url");
            _loc3_ = buildThumbnailUrl(null,var_1810);
         }
         catch(error:Error)
         {
            return null;
         }
         var_989 = null;
         return null;
      }
      
      public function getExternalImageUUID() : String
      {
         return var_3837;
      }
      
      private function buildThumbnailUrl(param1:String, param2:String) : String
      {
         if(param1 == "REJECTED")
         {
            return param1;
         }
         if(param1.indexOf("http") != 0)
         {
            param1 = var_1639 + param2 + param1;
         }
         param1 = param1.replace(".png","_small.png");
         if(param1.indexOf(".png") == -1)
         {
            param1 += "_small.png";
         }
         return param1;
      }
      
      private function getJsonValue(param1:String, param2:String, param3:String) : String
      {
         var _loc5_:Object = new JSONDecoder(param1,false).getValue();
         var _loc4_:String = _loc5_[param2];
         if(_loc4_ == null && param3 != null)
         {
            _loc4_ = _loc5_[param3];
         }
         return _loc4_;
      }
      
      private function loadExtraData(param1:String) : void
      {
         var _loc3_:String = var_3406 + param1;
         var _loc2_:URLLoader = new URLLoader(new URLRequest(_loc3_));
         _loc2_.addEventListener("complete",onExtraDataLoaded);
         _loc2_.addEventListener("ioError",onExtraDataError);
         var_3318 = true;
      }
      
      private function onExtraDataError(param1:Event) : void
      {
         class_21.log("Extra data failed to load " + param1.toString());
      }
      
      private function onExtraDataLoaded(param1:Event) : void
      {
         var _loc2_:String = URLLoader(param1.target).data;
         if(_loc2_.length == 0)
         {
            return;
         }
         var _loc3_:String = getJsonValue(_loc2_,"w","url");
         var_989 = buildThumbnailUrl(_loc3_,var_1810);
      }
      
      public function onUrlFromExtraDataService(param1:String) : void
      {
         var_989 = buildThumbnailUrl(param1,var_1810);
      }
      
      public function getExtraDataUrl() : String
      {
         return var_3406;
      }
      
      override public function dispose() : void
      {
         ExtraDataManager.furnitureDisposed(this);
         super.dispose();
      }
      
      override public function getImage(param1:int, param2:int) : BitmapData
      {
         if(!assetCollection)
         {
            return new BitmapData(1,1,true,0);
         }
         var _loc3_:String = getFullThumbnailAssetName(param2,32);
         if(assetCollection.getAsset(_loc3_) == null && object)
         {
            _loc3_ = object.getType() + "_icon_a";
         }
         if(assetCollection.getAsset(_loc3_) == null)
         {
            return new BitmapData(1,1,true,0);
         }
         var _loc4_:Object = assetCollection.getAsset(_loc3_).asset.content;
         if(!_loc4_)
         {
            return new BitmapData(1,1,true,0);
         }
         return (_loc4_ as BitmapData).clone();
      }
      
      override protected function getLibraryAssetNameForSprite(param1:IGraphicAsset, param2:IRoomObjectSprite) : String
      {
         return var_989;
      }
   }
}

