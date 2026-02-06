package com.sulake.habbo.nux
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.habbo.session.product.class_59;
   import com.sulake.habbo.communication.messages.outgoing.nux.class_2597;
   import com.sulake.habbo.communication.messages.incoming.nux.class_3217;
   import com.sulake.habbo.communication.messages.incoming.nux.class_3916;
   import com.sulake.habbo.communication.messages.incoming.nux.class_3961;
   
   public class NuxGiftSelectionView implements class_59
   {
      
      private var _frame:class_2250;
      
      private var var_59:HabboNuxDialogs;
      
      private var var_2235:class_1812;
      
      private var var_1407:Vector.<class_3217>;
      
      private var var_135:int;
      
      private var var_3804:Vector.<class_2597>;
      
      public function NuxGiftSelectionView(param1:HabboNuxDialogs, param2:Vector.<class_3217>)
      {
         super();
         var_59 = param1;
         var_1407 = param2;
         var_135 = 0;
         var_3804 = new Vector.<class_2597>();
         if(var_59.sessionDataManager && var_59.sessionDataManager.loadProductData(this))
         {
            show();
         }
      }
      
      public function productDataReady() : void
      {
         show();
      }
      
      public function dispose() : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
         var_59 = null;
         var_2235 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_59 == null;
      }
      
      private function hide() : void
      {
         if(var_59)
         {
            var_59.destroyNuxOfferView();
         }
      }
      
      private function show() : void
      {
         if(_frame != null)
         {
            _frame.dispose();
         }
         var _loc2_:XmlAsset = var_59.assets.getAssetByName("nux_gift_selection_xml") as XmlAsset;
         _frame = var_59.windowManager.buildFromXML(_loc2_.content as XML) as class_2250;
         if(_frame == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var _loc1_:class_1741 = _frame.findChildByTag("close");
         if(_loc1_)
         {
            _loc1_.visible = false;
         }
         populateStep();
      }
      
      private function populateStep() : void
      {
         var _loc6_:int = 0;
         var _loc2_:class_3916 = null;
         var _loc12_:class_1812 = null;
         var _loc3_:ITextWindow = null;
         var _loc9_:class_1775 = null;
         var _loc10_:class_1812 = null;
         var _loc14_:IStaticBitmapWrapperWindow = null;
         var _loc13_:String = null;
         var _loc15_:int = 0;
         var _loc4_:class_3961 = null;
         var _loc16_:String = null;
         var _loc8_:String = null;
         var _loc11_:class_1949 = null;
         var _loc17_:String = null;
         if(!var_1407 || !var_1407.length)
         {
            return;
         }
         var _loc1_:class_3217 = var_1407[var_135];
         var _loc5_:IItemListWindow = _frame.findChildByName("nux_gift_selection_list") as IItemListWindow;
         if(!var_2235)
         {
            var_2235 = _loc5_.getListItemAt(0) as class_1812;
         }
         _loc5_.removeListItems();
         var _loc7_:String = decodeURI(var_59.localizationManager.getLocalization("nux.gift.selection.separator",", "));
         _loc6_ = 0;
         while(_loc6_ < _loc1_.options.length)
         {
            _loc2_ = _loc1_.options[_loc6_];
            _loc12_ = var_2235.clone() as class_1812;
            _loc3_ = _loc12_.getChildByName("option_heading") as ITextWindow;
            _loc9_ = _loc12_.getChildByName("option_button") as class_1775;
            _loc10_ = _loc12_.getChildByName("option_thumbnail") as class_1812;
            _loc14_ = _loc10_.getChildByName("option_bitmap") as IStaticBitmapWrapperWindow;
            _loc13_ = "";
            if(_loc2_.productOfferList.length)
            {
               _loc15_ = 0;
               while(_loc15_ < _loc2_.productOfferList.length)
               {
                  _loc4_ = _loc2_.productOfferList[_loc15_];
                  _loc16_ = _loc4_.productCode;
                  _loc8_ = _loc4_.localizationKey;
                  if(_loc8_ != null)
                  {
                     _loc13_ += var_59.localizationManager.getLocalization(_loc8_,_loc8_);
                  }
                  else
                  {
                     _loc11_ = var_59.catalog.getProductData(_loc16_);
                     if(_loc11_ && _loc11_.name)
                     {
                        _loc13_ += _loc11_.name;
                     }
                     else
                     {
                        _loc13_ += var_59.localizationManager.getLocalization("product_" + _loc16_ + "_name","product_" + _loc16_ + "_name");
                     }
                  }
                  if(_loc15_ < _loc2_.productOfferList.length - 1)
                  {
                     _loc13_ += _loc7_;
                  }
                  _loc15_++;
               }
            }
            _loc17_ = _loc2_.thumbnailUrl;
            if(_loc17_)
            {
               _loc14_.assetUri = var_59.configuration.getProperty("image.library.url") + _loc17_;
            }
            _loc3_.text = _loc13_;
            _loc9_.name = _loc6_.toString();
            _loc9_.procedure = onSelectOption;
            _loc5_.addListItem(_loc12_);
            _loc6_++;
         }
         _loc5_.arrangeListItems();
         if(var_1407.length > 1)
         {
            _frame.caption = var_59.localizationManager.getLocalization("nux.gift.selection.title") + " " + (var_135 + 1) + "/" + var_1407.length;
         }
         _frame.center();
      }
      
      private function onSelectOption(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:class_3217 = null;
         var _loc6_:IItemListWindow = null;
         var _loc4_:int = 0;
         var _loc5_:class_2597 = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = var_1407[var_135];
            _loc6_ = _frame.findChildByName("nux_gift_selection_list") as IItemListWindow;
            _loc4_ = _loc6_.getListItemIndex(param2.parent);
            if(_loc4_ == -1)
            {
               return;
            }
            _loc5_ = new class_2597(_loc3_.dayIndex,_loc3_.stepIndex,_loc4_);
            var_3804.push(_loc5_);
            var_135 = var_135 + 1;
            if(var_135 == var_1407.length)
            {
               var_59.onSendGetGifts(var_3804);
            }
            else
            {
               show();
            }
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
   }
}

