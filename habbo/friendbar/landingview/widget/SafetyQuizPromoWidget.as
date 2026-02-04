package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.window.widgets.class_2478;
   
   public class SafetyQuizPromoWidget implements ILandingViewWidget
   {
      
      private var _landingView:HabboLandingView;
      
      private var _container:class_1812;
      
      private var _disposed:Boolean;
      
      public function SafetyQuizPromoWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function initialize() : void
      {
         _container = class_1812(_landingView.getXmlWindow("safety_quiz_promo"));
         _container.procedure = widgetProcedure;
         refresh();
      }
      
      private function widgetProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK" && param2.name == "safety_quiz_button")
         {
            _landingView.habboHelp.showSafetyBooklet();
         }
      }
      
      public function refresh() : void
      {
         if(_container != null && !_container.disposed)
         {
            class_2478(class_2010(_container.findChildByName("avatar")).widget).figure = _landingView.sessionDataManager.figure;
         }
      }
      
      public function get container() : class_1741
      {
         return _container;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_container != null)
            {
               _container.dispose();
               _container = null;
            }
            _landingView = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

