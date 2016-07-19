;;;; -*- Mode: LISP; Syntax: Common-lisp; Package: USER; Base: 10 -*-
;;;; Name:  Kevin Barroga                   Date: 2014 NOV 04
;;;; Course: ICS361                   Assignment: Assignment 4
;;;; File name: cobweb-animal2-data.lisp

;;; Additional sample animal data for COBWEB

(setf *feature-names* '(body-cover air water mouth birth appendage color place feet))

(setf *domains* 
      '((hair feathers spines scales) (fly no-fly) (no-swim swim) (teeth beak none) (live-birth eggs) 
      (legs wings fins) (brown white tawny black red-breast tuxedo gray golden) 
      (west ut-campus africa midwest antartic underground alpine tropics australia desert)	(no-web webbed)))

(setf *raw-examples*
      '(
	(Penguin   (feathers  no-fly swim    beak   eggs         wings  tuxedo      Antartic    webbed))
	(Robin     (feathers  fly    no-swim beak   eggs         wings  red-breast  Midwest     no-web))
	(Panther   (hair      no-fly no-swim teeth  live-birth   legs   black       Africa      no-web))
	(Grackle   (feathers  fly    no-swim beak   eggs         wings  black       UT-Campus   no-web))
	(Lion      (hair      no-fly no-swim teeth  live-birth   legs   tawny       Africa      no-web))
	(Eagle     (feathers  fly    no-swim beak   eggs         wings  white       West        no-web))
	(Bear      (hair      no-fly no-swim teeth  live-birth   legs   black       West        no-web))
	(Duck      (feathers  fly    swim    beak   eggs         wings  brown       Midwest     webbed))
  ;;;;  10 new instances of animal data                                                         
  (Elephant  (hair      no-fly swim    teeth  live-birth   legs   gray        Africa      no-web))
  (Hedgehog  (spines    no-fly no-swim teeth  live-birth   legs   brown       Underground no-web))
  (Gibbon    (hair      no-fly no-swim teeth  live-birth   legs   black       Africa      no-web))
  (Ibex      (hair      no-fly no-swim teeth  live-birth   legs   brown       Alpine      no-web))  
  (Narwhal   (hair      no-fly swim    none   live-birth   fins   black       Antartic    no-web))
  (Quetzal   (feathers  fly    no-swim beak   eggs         wings  red-breast  Tropics     no-web))
  (Camel     (hair      no-fly no-swim teeth  live-birth   legs   tawny       Africa      no-web))
  (Platypus  (hair      no-fly swim    beak   eggs         legs   brown       Australia   no-web))
  (Meerkat   (hair      no-fly no-swim teeth  live-birth   legs   golden      Africa      no-web))
  (Pangolin  (scales    no-fly no-swim teeth  live-birth   legs   golden      Underground no-web))
       ))

