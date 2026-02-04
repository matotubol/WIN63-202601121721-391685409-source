package com.sulake.habbo.avatar.alias
{
   public class AssetAlias
   {
      
      private var _name:String;
      
      private var var_777:String;
      
      private var _flipH:Boolean;
      
      private var _flipV:Boolean;
      
      public function AssetAlias(param1:XML)
      {
         super();
         _name = String(param1.@name);
         var_777 = String(param1.@link);
         _flipH = Boolean(parseInt(param1.@fliph));
         _flipV = Boolean(parseInt(param1.@flipv));
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get link() : String
      {
         return var_777;
      }
      
      public function get flipH() : Boolean
      {
         return _flipH;
      }
      
      public function get flipV() : Boolean
      {
         return _flipV;
      }
   }
}

