package com.sulake.habbo.ui.widget.furniture.trophy
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextLinkWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   
   public class NikoTrophyView implements ITrophyView
   {
      
      private var var_3530:int;
      
      private var var_16:TrophyFurniWidget;
      
      private var _window:class_1812;
      
      public function NikoTrophyView(param1:TrophyFurniWidget, param2:int)
      {
         super();
         var_16 = param1;
         var_3530 = param2;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_16 = null;
      }
      
      public function showInterface() : Boolean
      {
         var _loc2_:class_1741 = null;
         var _loc4_:ITextWindow = null;
         var _loc6_:ITextLinkWindow = null;
         var _loc3_:ITextWindow = null;
         var _loc7_:IStaticBitmapWrapperWindow = null;
         var _loc8_:IAsset = var_16.assets.getAssetByName("niko_trophy");
         var _loc1_:XmlAsset = XmlAsset(_loc8_);
         if(_loc1_ == null)
         {
            return false;
         }
         if(_window == null)
         {
            _window = var_16.windowManager.buildFromXML(_loc1_.content as XML) as class_1812;
         }
         _window.center();
         _loc2_ = _window.findChildByName("header_button_close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onCloseElem);
         }
         _loc4_ = _window.findChildByName("html_textbox") as ITextWindow;
         if(_loc4_ != null)
         {
            switch(var_3530 - 10)
            {
               case 0:
                  _loc4_.text = var_16.localizations.getLocalization("niko.trophy.description.silver");
                  break;
               case 10:
                  _loc4_.text = var_16.localizations.getLocalization("niko.trophy.description.gold");
            }
         }
         _loc6_ = _window.findChildByName("store_link") as ITextLinkWindow;
         if(_loc6_ != null)
         {
            _loc6_.addEventListener("WME_CLICK",onAppstoreLink);
         }
         _loc3_ = _window.findChildByName("date") as ITextWindow;
         if(_loc3_ != null)
         {
            var_16.localizations.registerParameter("trophy.niko.date","date",var_16.date);
            _loc3_.text = var_16.localizations.getLocalization("trophy.niko.date");
         }
         _loc7_ = _window.findChildByName("preview_image") as IStaticBitmapWrapperWindow;
         if(_loc7_ != null)
         {
            if(var_3530 == 20)
            {
               _loc7_.assetUri = "${image.library.url}niko/niko_trophy_gold.png";
            }
            else
            {
               _loc7_.assetUri = "${image.library.url}niko/niko_trophy_silver.png";
            }
         }
         _loc7_ = _window.findChildByName("store_image") as IStaticBitmapWrapperWindow;
         if(_loc7_ != null)
         {
            _loc7_.assetUri = "${image.library.url}niko/" + var_16.configuration.getProperty("niko.trophy.appstore.image") + ".png";
         }
         var _loc9_:IRegionWindow = _window.findChildByName("appstore_region") as IRegionWindow;
         if(_loc9_)
         {
            _loc9_.addEventListener("WME_CLICK",onAppstoreLink);
         }
         return true;
      }
      
      public function disposeInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onAppstoreLink(param1:WindowMouseEvent) : void
      {
         var _loc2_:String = var_16.configuration.getProperty("niko.appstore.link.url");
         HabboWebTools.openWebPage(_loc2_,"habboMain");
      }
      
      private function onCloseElem(param1:WindowMouseEvent) : void
      {
         disposeInterface();
      }
   }
}

