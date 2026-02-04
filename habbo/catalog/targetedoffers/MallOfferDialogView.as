package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.targetedoffers.data.HabboMallOffer;
   
   public class MallOfferDialogView
   {
      
      private var var_55:OfferController;
      
      private var _window:class_1812;
      
      private var _offer:HabboMallOffer;
      
      public function MallOfferDialogView(param1:OfferController, param2:HabboMallOffer)
      {
         super();
         var_55 = param1;
         _offer = param2;
         _window = class_1812(var_55.catalog.windowManager.buildFromXML(XML(var_55.catalog.assets.getAssetByName("targeted_offer_habbomall_xml").content)));
         class_2250(_window).title.text = getLocalization(_offer.title);
         ITextWindow(_window.findChildByName("txt_title")).text = getLocalization(_offer.title);
         if(param2.imageUrl && param2.imageUrl.length > 0)
         {
            var _loc3_:String = (var_55.catalog as class_16).getProperty("image.library.url");
            IStaticBitmapWrapperWindow(_window.findChildByName("bmp_illustration")).assetUri = null + param2.imageUrl;
         }
         _window.procedure = onInput;
         _window.center();
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onInput(param1:class_1758, param2:class_1741) : void
      {
         if(!var_55 || !_offer)
         {
            return;
         }
         if(param1.type == "WME_DOWN")
         {
            switch(param2.name)
            {
               case "header_button_close":
                  var_55.onHabboMallOfferClosed(_offer);
                  break;
               case "btn_buy":
                  var_55.onHabboMallOfferOpened(_offer);
            }
         }
      }
      
      private function getLocalization(param1:String, param2:String = null) : String
      {
         return var_55.catalog.localization.getLocalization(param1,param2 || param1);
      }
   }
}

