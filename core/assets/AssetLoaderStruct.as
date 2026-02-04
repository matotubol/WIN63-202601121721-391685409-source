package com.sulake.core.assets
{
   import com.sulake.core.assets.loaders.class_1739;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   
   public class AssetLoaderStruct extends EventDispatcherWrapper implements class_13
   {
      
      private var var_1763:class_1739;
      
      private var _assetName:String;
      
      public function AssetLoaderStruct(param1:String, param2:class_1739)
      {
         super();
         _assetName = param1;
         var_1763 = param2;
      }
      
      public function get assetName() : String
      {
         return _assetName;
      }
      
      public function get assetLoader() : class_1739
      {
         return var_1763;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(var_1763 != null)
            {
               if(!var_1763.disposed)
               {
                  var_1763.dispose();
                  var_1763 = null;
               }
            }
            super.dispose();
         }
      }
   }
}

