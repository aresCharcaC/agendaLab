@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Bienvenido a Agenda de Contactos') }}</div>

                <div class="card-body">
                    @if (session('status'))
                        <div class="alert alert-success" role="alert">
                            {{ session('status') }}
                        </div>
                    @endif

                    <div class="text-center mb-4">
                        <h2>Gestiona tus contactos de forma fácil y segura</h2>
                        <p class="lead">Una aplicación simple para mantener organizados todos tus contactos.</p>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="card mb-3">
                                <div class="card-body text-center">
                                    <i class="fa fa-users fa-3x mb-3 text-primary" aria-hidden="true"></i>
                                    <h5 class="card-title">Almacena tus contactos</h5>
                                    <p class="card-text">Guarda nombres, teléfonos, emails y direcciones en un solo lugar.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card mb-3">
                                <div class="card-body text-center">
                                    <i class="fa fa-shield fa-3x mb-3 text-primary" aria-hidden="true"></i>
                                    <h5 class="card-title">Acceso seguro</h5>
                                    <p class="card-text">Cada usuario tiene acceso únicamente a sus propios contactos.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-4">
                        @guest
                            <a href="{{ route('login') }}" class="btn btn-primary mx-2">Iniciar sesión</a>
                            <a href="{{ route('register') }}" class="btn btn-outline-primary mx-2">Registrarse</a>
                        @else
                            <a href="{{ route('contacts.index') }}" class="btn btn-primary">Ver mis contactos</a>
                        @endguest
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection