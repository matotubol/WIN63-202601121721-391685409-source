package com.sulake.core.window.graphics.renderer
{
   import flash.geom.Rectangle;
   
   public class SkinTemplateEntity implements ISkinTemplateEntity
   {
      
      protected var var_197:uint;
      
      protected var _name:String;
      
      protected var var_230:String;
      
      protected var var_2336:Rectangle;
      
      public function SkinTemplateEntity(param1:String, param2:String, param3:uint, param4:Rectangle)
      {
         super();
         var_197 = param3;
         _name = param1;
         var_230 = param2;
         var_2336 = param4;
      }
      
      public function get id() : uint
      {
         return var_197;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get region() : Rectangle
      {
         return var_2336;
      }
   }
}

