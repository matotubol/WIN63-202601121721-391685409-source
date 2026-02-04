package com.sulake.habbo.catalog.recycler
{
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   
   public class RecycleRewardDisplayWrapper implements IProductDisplayInfo
   {
      
      private var var_576:String;
      
      private var var_3320:int;
      
      public function RecycleRewardDisplayWrapper(param1:String, param2:int)
      {
         super();
         var_576 = param1;
         var_3320 = param2;
      }
      
      public function get productTypeId() : int
      {
         switch(var_576)
         {
            case "chat_style":
               return 9;
            case "i":
               return 0;
            case "s":
               return 1;
            default:
               return -1;
         }
      }
      
      public function get itemTypeId() : String
      {
         return String(var_3320);
      }
      
      public function get petFigureString() : String
      {
         return "";
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return undefined;
      }
   }
}

