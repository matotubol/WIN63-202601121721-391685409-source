package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.targetedoffers.data.HabboMallOffer;
   
   public class MallOfferMinimizedView extends OfferView
   {
      
      private static const IMAGE_DEFAULT_URL:String = "targetedoffers/offer_default_icon.png";
      
      private var var_4935:HabboMallOffer;
      
      public function MallOfferMinimizedView(param1:OfferController, param2:HabboMallOffer)
      {
         super(param1,null);
         var_4935 = param2;
         _window = class_1812(var_55.catalog.windowManager.buildFromXML(XML(var_55.catalog.assets.getAssetByName("targeted_offer_minimized_xml").content)));
         var _loc4_:ITextWindow = ITextWindow(_window.findChildByName("txt_title"));
         if(_loc4_)
         {
            _loc4_.text = getLocalization(param2.title);
         }
         var _loc3_:String = (var_55.catalog as class_16).getProperty("image.library.url");
         IStaticBitmapWrapperWindow(_window.findChildByName("bmp_icon")).assetUri = _loc3_ + "targetedoffers/offer_default_icon.png";
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
            var_55.maximizeMallOffer(var_4935);
            param2.name;
         }
      }
      
      public function get window() : class_1741
      {
         return _window;
      }
   }
}

