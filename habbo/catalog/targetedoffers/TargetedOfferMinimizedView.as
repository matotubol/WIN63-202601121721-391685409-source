package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
   
   public class TargetedOfferMinimizedView extends OfferView
   {
      
      private static const IMAGE_DEFAULT_URL:String = "targetedoffers/offer_default_icon.png";
      
      public function TargetedOfferMinimizedView(param1:OfferController, param2:TargetedOffer)
      {
         super(param1,param2);
         _window = class_1812(var_55.catalog.windowManager.buildFromXML(XML(var_55.catalog.assets.getAssetByName("targeted_offer_minimized_xml").content)));
         var _loc5_:ITextWindow = ITextWindow(_window.findChildByName("txt_title"));
         if(_loc5_)
         {
            _loc5_.text = getLocalization(param2.title);
         }
         var _loc3_:String = (var_55.catalog as class_16).getProperty("image.library.url");
         var _loc4_:String = param2.iconImageUrl && param2.iconImageUrl.length > 0 ? param2.iconImageUrl : "targetedoffers/offer_default_icon.png";
         IStaticBitmapWrapperWindow(_window.findChildByName("bmp_icon")).assetUri = _loc3_ + _loc4_;
         var_929 = getLocalization("targeted.offer.minimized.timeleft","");
         if(_offer.expirationTime == 0)
         {
            var _loc6_:IItemListWindow = _window.findChildByName("itemlist") as IItemListWindow;
            if(_loc6_)
            {
               null.removeListItem(_window.findChildByName("cnt_time_left"));
            }
         }
         else
         {
            startUpdateTimer();
         }
         _window.procedure = onInput;
         var_55.attachExtension(_window);
      }
      
      private function onInput(param1:class_1758, param2:class_1741) : void
      {
         if(!var_55)
         {
            return;
         }
         if(param1.type == "WME_DOWN")
         {
            var_55.maximizeOffer(_offer);
            param2.name;
         }
      }
      
      public function get window() : class_1741
      {
         return _window;
      }
   }
}

