package com.sulake.core.assets
{
   import flash.utils.getQualifiedClassName;
   
   public class UnknownAsset implements IAsset
   {
      
      private var _disposed:Boolean = false;
      
      private var _content:Object = null;
      
      private var _decl:AssetTypeDeclaration;
      
      private var var_989:String;
      
      public function UnknownAsset(param1:AssetTypeDeclaration, param2:String = null)
      {
         super();
         _decl = param1;
         var_989 = param2;
      }
      
      public function get url() : String
      {
         return var_989;
      }
      
      public function get content() : Object
      {
         return _content;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get declaration() : AssetTypeDeclaration
      {
         return _decl;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            _content = null;
            _decl = null;
            var_989 = null;
         }
      }
      
      public function setUnknownContent(param1:Object) : void
      {
         _content = param1;
      }
      
      public function setFromOtherAsset(param1:IAsset) : void
      {
         _content = param1.content as Object;
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
      }
      
      public function toString() : String
      {
         return getQualifiedClassName(this) + ": " + _content;
      }
   }
}

