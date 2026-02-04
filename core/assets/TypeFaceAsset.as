package com.sulake.core.assets
{
   import com.sulake.core.utils.class_1860;
   import flash.text.Font;
   
   public class TypeFaceAsset implements IAsset
   {
      
      protected var _decl:AssetTypeDeclaration;
      
      protected var _content:Font;
      
      protected var _disposed:Boolean = false;
      
      public function TypeFaceAsset(param1:AssetTypeDeclaration, param2:String = null)
      {
         super();
         _decl = param1;
      }
      
      public function get url() : String
      {
         return null;
      }
      
      public function get content() : Object
      {
         return _content as Object;
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
            _decl = null;
            _content = null;
            _disposed = true;
         }
      }
      
      public function setUnknownContent(param1:Object) : void
      {
         try
         {
            if(param1 is Class)
            {
               _content = Font(class_1860.registerFont(param1 as Class));
            }
         }
         catch(e:Error)
         {
            throw new Error("Failed to register font from resource: " + param1);
         }
      }
      
      public function setFromOtherAsset(param1:IAsset) : void
      {
         if(param1 is TypeFaceAsset)
         {
            _content = TypeFaceAsset(param1)._content;
            return;
         }
         throw new Error("Provided asset should be of type FontAsset!");
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
      }
   }
}

