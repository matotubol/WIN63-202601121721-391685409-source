package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.session.product.class_1949;
   
   public class ClubGiftConfirmationDialog
   {
      
      private var _offer:class_1793;
      
      private var var_55:ClubGiftController;
      
      private var var_18:class_2250;
      
      public function ClubGiftConfirmationDialog(param1:ClubGiftController, param2:class_1793)
      {
         super();
         _offer = param2;
         var_55 = param1;
         showConfirmation();
      }
      
      public function dispose() : void
      {
         var_55 = null;
         _offer = null;
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
      }
      
      public function showConfirmation() : void
      {
         if(!_offer || !var_55)
         {
            return;
         }
         var_18 = createWindow("club_gift_confirmation") as class_2250;
         if(!var_18)
         {
            return;
         }
         var_18.procedure = windowEventHandler;
         var_18.center();
         var _loc2_:ITextWindow = var_18.findChildByName("item_name") as ITextWindow;
         if(_loc2_)
         {
            _loc2_.text = getProductName();
         }
         var _loc1_:class_1812 = var_18.findChildByName("image_border") as class_1812;
         if(!_loc1_)
         {
            return;
         }
         if(!_offer.productContainer)
         {
            return;
         }
         _offer.productContainer.view = _loc1_;
         _offer.productContainer.initProductIcon(var_55.roomEngine);
      }
      
      private function getProductName() : String
      {
         var _loc1_:class_1949 = null;
         if(_offer && _offer.product)
         {
            _loc1_ = _offer.product.productData;
            if(_loc1_)
            {
               return _loc1_.name;
            }
         }
         return "";
      }
      
      private function windowEventHandler(param1:class_1758, param2:class_1741) : void
      {
         if(!param1 || !param2 || !var_55 || !_offer)
         {
            return;
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "select_button":
               var_55.confirmSelection(_offer.localizationId);
               break;
            case "header_button_close":
            case "cancel_button":
               var_55.closeConfirmation();
         }
      }
      
      private function createWindow(param1:String) : class_1741
      {
         if(!var_55 || !var_55.assets || !var_55.windowManager)
         {
            return null;
         }
         var _loc3_:XmlAsset = var_55.assets.getAssetByName(param1) as XmlAsset;
         if(!_loc3_ || !_loc3_.content)
         {
            return null;
         }
         var _loc2_:XML = _loc3_.content as XML;
         if(!_loc2_)
         {
            return null;
         }
         return var_55.windowManager.buildFromXML(_loc2_);
      }
   }
}

