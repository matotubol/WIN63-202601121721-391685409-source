package com.sulake.core.assets
{
   import com.sulake.core.runtime.class_13;
   
   public interface IAsset extends class_13
   {
      
      function get url() : String;
      
      function get content() : Object;
      
      function get declaration() : AssetTypeDeclaration;
      
      function setUnknownContent(param1:Object) : void;
      
      function setFromOtherAsset(param1:IAsset) : void;
      
      function setParamsDesc(param1:XMLList) : void;
   }
}

