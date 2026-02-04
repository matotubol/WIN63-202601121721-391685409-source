package com.sulake.core.assets
{
   import flash.media.Sound;
   import flash.utils.ByteArray;
   
   public class SoundAsset implements IAsset
   {
      
      private var _disposed:Boolean = false;
      
      private var _content:Sound = null;
      
      private var _decl:AssetTypeDeclaration;
      
      private var var_989:String;
      
      public function SoundAsset(param1:AssetTypeDeclaration, param2:String = null)
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
            _disposed = true;
            _content = null;
            _decl = null;
            var_989 = null;
         }
      }
      
      public function setUnknownContent(param1:Object) : void
      {
         if(param1 is Sound)
         {
            if(_content)
            {
               _content.close();
            }
            _content = param1 as Sound;
            return;
         }
         if(param1 is ByteArray)
         {
         }
         if(param1 is Class)
         {
            if(_content)
            {
               _content.close();
            }
            _content = new (param1 as Class)() as Sound;
            return;
         }
         if(param1 is SoundAsset)
         {
            if(_content)
            {
               _content.close();
            }
            _content = SoundAsset(param1)._content;
            return;
         }
      }
      
      public function setFromOtherAsset(param1:IAsset) : void
      {
         if(param1 is SoundAsset)
         {
            _content = SoundAsset(param1)._content;
         }
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
      }
   }
}

