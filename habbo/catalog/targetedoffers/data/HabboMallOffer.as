package com.sulake.habbo.catalog.targetedoffers.data
{
   public class HabboMallOffer
   {
      
      private var var_4004:int;
      
      private var var_3099:String;
      
      private var var_839:String;
      
      private var _highlight:String;
      
      private var var_735:String;
      
      private var var_319:String;
      
      private var _smallImageUrl:String;
      
      private var var_2693:int;
      
      public function HabboMallOffer(param1:Object)
      {
         super();
         var_4004 = parseInt(param1.targetedOfferId);
         var_3099 = param1.identifier;
         var_839 = param1.header;
         _highlight = param1.highlight;
         var_735 = param1.description;
         var_319 = param1.imageUrl;
         _smallImageUrl = param1.smallImageUrl;
         var_2693 = parseInt(param1.trackingStateCode);
      }
      
      public function get targetedOfferId() : int
      {
         return var_4004;
      }
      
      public function get identifier() : String
      {
         return var_3099;
      }
      
      public function get title() : String
      {
         return var_839;
      }
      
      public function get highlight() : String
      {
         return _highlight;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function get imageUrl() : String
      {
         return var_319;
      }
      
      public function get smallImageUrl() : String
      {
         return _smallImageUrl;
      }
      
      public function get trackingState() : int
      {
         return var_2693;
      }
   }
}

