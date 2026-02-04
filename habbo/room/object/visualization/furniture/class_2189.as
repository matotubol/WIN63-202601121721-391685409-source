package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.core.runtime.exceptions.Exception;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class class_2189 extends class_1866
   {
      
      private var var_2245:String = null;
      
      public function class_2189()
      {
         super();
      }
      
      private static function onThumbnailError(param1:ErrorEvent) : void
      {
         class_21.log("External Image thumbnail download error: " + param1.toString());
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc4_:String = null;
         if(object != null)
         {
            _loc4_ = getThumbnailURL();
            if(var_2245 != _loc4_)
            {
               var_2245 = _loc4_;
               if(var_2245 != null && var_2245 != "")
               {
                  var _loc2_:Loader = new Loader();
                  null.name = _loc4_;
                  null.contentLoaderInfo.addEventListener("complete",onThumbnailLoaded);
                  null.contentLoaderInfo.addEventListener("ioError",onThumbnailError);
                  null.contentLoaderInfo.addEventListener("securityError",onThumbnailError);
                  var _loc3_:LoaderContext = new LoaderContext(true);
                  null.checkPolicyFile = true;
                  null.load(new URLRequest(_loc4_),null);
               }
               else
               {
                  setThumbnailImages(null);
               }
            }
         }
         return super.updateModel(param1);
      }
      
      protected function getThumbnailURL() : String
      {
         throw new Exception("This method must be overridden!");
      }
      
      private function onThumbnailLoaded(param1:Event) : void
      {
         var _loc3_:LoaderInfo = param1.target as LoaderInfo;
         var _loc2_:Bitmap = _loc3_.content as Bitmap;
         if(_loc2_ != null)
         {
            setThumbnailImages(_loc2_.bitmapData);
         }
         else
         {
            setThumbnailImages(null);
         }
      }
   }
}

