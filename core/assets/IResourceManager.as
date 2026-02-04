package com.sulake.core.assets
{
   import com.sulake.core.runtime.class_13;
   
   public interface IResourceManager extends class_13
   {
      
      function createAsset(param1:String, param2:Class, param3:Object) : IAsset;
      
      function retrieveAsset(param1:String, param2:class_3067) : void;
      
      function isSameAsset(param1:String, param2:String) : Boolean;
      
      function removeAsset(param1:String) : void;
   }
}

