package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.core.utils.class_55;
   import com.sulake.room.object.IRoomObjectModel;
   
   public class class_2190 extends class_2189
   {
      
      protected static const THUMBNAIL_URL_KEY:String = "THUMBNAIL_URL";
      
      public function class_2190()
      {
         super();
      }
      
      override protected function getThumbnailURL() : String
      {
         var _loc3_:IRoomObjectModel = object.getModel();
         var _loc2_:class_55 = _loc3_.getStringToStringMap("furniture_data");
         var _loc1_:String = _loc3_.getString("session_url_prefix");
         if(_loc1_ == null)
         {
            return null;
         }
         return _loc1_ + _loc2_.getValue("THUMBNAIL_URL");
      }
   }
}

