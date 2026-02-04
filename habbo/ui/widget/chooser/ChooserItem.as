package com.sulake.habbo.ui.widget.chooser
{
   import com.sulake.habbo.utils.class_2262;
   
   public class ChooserItem
   {
      
      private var var_197:int;
      
      private var var_191:int;
      
      private var _name:String;
      
      private var var_2997:String;
      
      private var var_230:int;
      
      private var _lowerCaseName:String;
      
      public function ChooserItem(param1:int, param2:int, param3:String, param4:String = null, param5:int = 0)
      {
         super();
         var_197 = param1;
         var_191 = param2;
         _name = param3;
         var_2997 = param4;
         var_230 = param5;
         _lowerCaseName = _name.toLowerCase();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get owner() : String
      {
         if(class_2262.isBuilderClubId(var_197))
         {
            return "Builders Club";
         }
         return var_2997;
      }
      
      public function get lowerCaseName() : String
      {
         return _lowerCaseName;
      }
   }
}

