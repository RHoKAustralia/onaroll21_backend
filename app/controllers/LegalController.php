<?php
/**
 * @author En Masse Pty Ltd <http://enmasse.com.au>
 */
class LegalController extends BaseController {
    /**
     * Terms and services
     * @return mixed
     */
    public function getTnc() {
        return View::make('legal/tos')
            ->with('title', 'Terms Of Services');
    }

    /**
     * Privacy Policies
     * @return mixed
     */
    public function getPrivacy() {
        return View::make('legal/privacy')
            ->with('title', 'Privacy Policy');
    }

    /**
     * Faq of the site
     * @return mixed
     */
    public function getFaq() {
        return View::make('legal/faq')
            ->with('title', 'Privacy Policy');
    }

    /**
     * About On A Roll 21
     * @return mixed
     */
    public function getAbout() {
        return View::make('legal/about')
            ->with('title', 'About Us');
    }
}