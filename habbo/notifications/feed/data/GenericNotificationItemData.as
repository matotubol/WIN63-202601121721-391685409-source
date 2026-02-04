package com.sulake.habbo.notifications.feed.data
{
   import flash.display.BitmapData;
   
   public class GenericNotificationItemData
   {
      
      private var var_839:String;
      
      private var var_2416:int;
      
      private var var_735:String;
      
      private var var_4002:BitmapData;
      
      private var var_952:BitmapData;
      
      private var var_3656:String;
      
      private var var_4975:String;
      
      public function GenericNotificationItemData()
      {
         super();
      }
      
      public function get title() : String
      {
         return var_839;
      }
      
      public function get timeStamp() : int
      {
         return var_2416;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function get decorationImage() : BitmapData
      {
         return var_4002;
      }
      
      public function get iconImage() : BitmapData
      {
         return var_952;
      }
      
      public function get buttonAction() : String
      {
         return var_3656;
      }
      
      public function get buttonCaption() : String
      {
         return var_4975;
      }
      
      public function set title(param1:String) : void
      {
         var_839 = param1;
      }
      
      public function set timeStamp(param1:int) : void
      {
         var_2416 = param1;
      }
      
      public function set description(param1:String) : void
      {
         var_735 = param1;
      }
      
      public function set decorationImage(param1:BitmapData) : void
      {
         var_4002 = param1;
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         var_952 = param1;
      }
      
      public function set buttonAction(param1:String) : void
      {
         var_3656 = param1;
      }
      
      public function set buttonCaption(param1:String) : void
      {
         var_4975 = param1;
      }
   }
}

